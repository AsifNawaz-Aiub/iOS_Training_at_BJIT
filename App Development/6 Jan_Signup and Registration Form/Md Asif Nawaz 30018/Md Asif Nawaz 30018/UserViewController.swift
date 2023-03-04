//
//  UserViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 10/1/23.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noteTextField: UITextView!
    var userName = ""
    var notes = [NoteModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       
        
        let dictionaryToSave : [String:Any] = ["isLoggedIn": true, "user": "user"]
        writeToPilist(dictionaryToSave: dictionaryToSave)
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    func loadData(){
        notes = NoteDataModel().getNoteByUser(userName: userName)!
        let allNotes = NoteDataModel().getNoteByUser(userName: userName)
        if let allNotes = allNotes {
            notes = allNotes
        }
        UserDefaults.standard.set(userName, forKey: "uname")
    }
    @IBAction func logoutBtnAction(_ sender: Any) {
        guard let resourcePath =  Bundle.main.resourcePath else {return}
        let fileURL =  URL(fileURLWithPath: resourcePath).appendingPathComponent("custom.plist")
        updatePiList(fileURL: fileURL)
    }
    @IBAction func saveNoteBtnAction(_ sender: Any) {
        notes.append(NoteDataModel().createNote(note: noteTextField.text, userName: userName))
        tableView.reloadData()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UserViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Notes"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! UserCustomTableViewCell
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateToStr = dateFormatter.string(from: notes[indexPath.row].createdAt!)
        cell.label.text = dateToStr
        cell.note.text = notes[indexPath.row].note!
        return cell
    }
    
    
}



//func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//    
//    let deleteAction = UIContextualAction(style: .destructive, title: nil){ [weak self] _,_, completion in
//        
//        guard let self = self else{return}
//        completion(true)
//       // self.intializeAlert(indexPath : [indexPath])
//    }
//    let editAction = UIContextualAction(style: .normal, title: nil){ [weak self] _,_, completion in
//        guard let self = self else{return}
//        completion(true)
//        //self.intializeEditAlert(index: indexPath.row)
//       
//    }
//    deleteAction.image = UIImage(systemName: "trash")
//    deleteAction.backgroundColor =  .systemRed
//    editAction.image = UIImage(systemName: "pencil")
//    editAction.backgroundColor =  .systemYellow
//    let swipeAction =  UISwipeActionsConfiguration (actions: [deleteAction, editAction])
//    
//    return swipeAction
//    
//}
