//
//  ViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 6/1/23.
//

import UIKit

enum Theme : Codable {
    case dark
    case light
}


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var styleSegBtn: UISegmentedControl!
    var users: [UserModel] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getCurrentTheme()
        self.navigationItem.hidesBackButton = true
        users =  UserDataModel().getAllUsers()
        UserDefaults.standard.set("admin", forKey: "uname")
        let dictionaryToSave : [String:Any] = ["isLoggedIn": true, "user": "admin"]
        writeToPilist(dictionaryToSave: dictionaryToSave)
        tableView.delegate = self
        tableView.dataSource = self
        
       
    }
    func getCurrentTheme(){
        guard let currentThemeData = UserDefaults.standard.data(forKey: "theme") else { return }
        let decoder = JSONDecoder()
        let currentTheme = try? decoder.decode(Theme.self, from: currentThemeData)
        if currentTheme == .dark{
            tableView.backgroundColor = .black
            styleSegBtn.selectedSegmentIndex = 1
        }else if currentTheme == .light{
            tableView.backgroundColor = .white
            styleSegBtn.selectedSegmentIndex = 0
        }
    }
    @IBAction func styleSegBtnAction(_ sender: Any) {
        let encoder = JSONEncoder()
        
        if styleSegBtn.selectedSegmentIndex == 0 {
            tableView.backgroundColor = .white
            let data = try? encoder.encode(Theme.light)
            UserDefaults.standard.set(data, forKey: "theme")
        }else if styleSegBtn.selectedSegmentIndex == 1{
            tableView.backgroundColor = .black
            let data = try? encoder.encode(Theme.dark)
            UserDefaults.standard.set(data, forKey: "theme")
        }
    }
    @IBAction func logoutBtnAction(_ sender: Any) {
        guard let resourcePath =  Bundle.main.resourcePath else {return}
        let fileURL =  URL(fileURLWithPath: resourcePath).appendingPathComponent("custom.plist")
        updatePiList(fileURL: fileURL)
    }
    func writeToPilist(dictionaryToSave:[String:Any]){
        guard let resourcePath =  Bundle.main.resourcePath else {return}
        let fileURL =  URL(fileURLWithPath: resourcePath).appendingPathComponent("custom.plist")
        do{
            print(fileURL)
            let data =  try PropertyListSerialization.data(fromPropertyList: dictionaryToSave, format: .xml, options: 0)
            try data.write(to: fileURL)
        }catch{
            print(error)
        }
    }
    func updatePiList(fileURL: URL){
        guard let data = try? Data(contentsOf: fileURL) else{return}
        guard var customPilistDictionary = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String:Any] else{return}
        customPilistDictionary["isLoggedIn"] = false
        writeToPilist(dictionaryToSave: customPilistDictionary)
        self.navigationController?.popViewController(animated: true)
    }
    
    func handleDeleteAction (indexPath : [IndexPath]) {
        tableView.beginUpdates()
      
        let result = UserDataModel().deleteUser(userToDelete: users[indexPath[0].row])
        if result{
        }else{
            print("Cant Delete! Error Occured!")
        }
        
        tableView.endUpdates()
        tableView.reloadData()
        
    }
    
    func intializeAlert(indexPath : [IndexPath]){
        let alertController = UIAlertController(title: "Delete Item", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.handleDeleteAction (indexPath : indexPath)
        })
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func  intializeEditAlert(index:Int) {
            let alert = UIAlertController(title: "Edit", message: "Edit User Full Name", preferredStyle: .alert)

        
            alert.addTextField { (textField) in
                
                textField.text = self.users[index].fullName
            }
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] (_) in
                guard let textField = alert.textFields![0].text, let self = self else{return}
               // print("Text field: \(textField?.text ?? "nil")")
               let result =  UserDataModel().updateRecord(index: index, editedName: textField, users: &self.users)
                if result{
                    self.tableView.reloadData()
                }
            }))
          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
          alert.addAction(cancelAction)

           
            self.present(alert, animated: true, completion: nil)
        }

    
    
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Users"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.fullNameLabel.text =  users[indexPath.row].fullName
        cell.userNameLabel.text =  users[indexPath.row].email
        
//        print(users[indexPath.row].email)
//        print(users[indexPath.row].password)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil){ [weak self] _,_, completion in
            
            guard let self = self else{return}
            completion(true)
            self.intializeAlert(indexPath : [indexPath])
        }
        let editAction = UIContextualAction(style: .normal, title: nil){ [weak self] _,_, completion in
            guard let self = self else{return}
            completion(true)
            self.intializeEditAlert(index: indexPath.row)
           
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor =  .systemRed
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor =  .systemYellow
        let swipeAction =  UISwipeActionsConfiguration (actions: [deleteAction, editAction])
        
        return swipeAction
        
    }
    
    
    
}
