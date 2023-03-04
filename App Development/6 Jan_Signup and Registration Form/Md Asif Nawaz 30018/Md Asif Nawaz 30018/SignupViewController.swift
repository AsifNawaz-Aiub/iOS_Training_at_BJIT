//
//  SignupViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 6/1/23.
//

import UIKit
import Foundation
import CoreData
struct Form{
    var fullNameTextField: String
    var emailTextField: String
    var passwordTextField: String
}
class SignupViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var users: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userModelDataModel = UserDataModel()
        users  =  userModelDataModel.getAllUsers()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupBtnAction(_ sender: Any) {
        
        let userModelDataModel = UserDataModel()
        let formData = Form(fullNameTextField: fullNameTextField.text!, emailTextField: emailTextField.text!, passwordTextField: passwordTextField.text!)
        let result  =  userModelDataModel.createUser( formData: formData)
        users.append(result)
        showAlert()
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Registration", message: "Signup Successfull", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default) { [weak self] _ in
            //self?.performSegue(withIdentifier: "connector", sender: nil)
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
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


