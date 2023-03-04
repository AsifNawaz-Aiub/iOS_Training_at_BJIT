//
//  ViewController.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 7/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var names : [String] = ["Asif", "Rony", "Shifat", "Faiaz"]
    @IBOutlet weak var appendTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
   
    @IBAction func appendButtonAction(_ sender: Any) {
        
        if let appendTextFieldText = appendTextField.text {
            
            if (appendTextFieldText != ""){
                names.append(appendTextFieldText)
                tableView.reloadData()
                // tableView.reloadRows(at: [IndexPath(row: names.count - 1, section: 0)], with: .fade)
                appendTextField.text = ""
            }
        }
    }
    
}
extension ViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            names.remove(at: indexPath.row)
            tableView.endUpdates()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
            return cell
        //}
    }
    
    
    
}
extension ViewController : UITableViewDelegate {
    
}
