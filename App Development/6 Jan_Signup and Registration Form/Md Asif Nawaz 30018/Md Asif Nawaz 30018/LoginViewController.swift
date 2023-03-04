//
//  LoginViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 9/1/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeBtn: UISegmentedControl!
   var doesKeyChainExist = false
    override func viewDidLoad() {
        super.viewDidLoad()
        rememberMeBtn.selectedSegmentIndex = 1
        
        if let currentUserName =  UserDefaults.standard.string(forKey: "uname"){
            readFromKeyChain(service:"password", account : currentUserName )
        }
     
       
        if let loginStatus : [String:Any] = readFromPlist(){
            let isLoggedIn = loginStatus["isLoggedIn"] as? Bool
            if let isLoggedIn = isLoggedIn {
                if isLoggedIn == true {
                    let userType = loginStatus["user"] as! String
                    
                    if userType == "admin"{
                        performSegue(withIdentifier: "homePage", sender: nil)
                    }
                    else{
                        performSegue(withIdentifier: "userHomePage", sender: nil)
                    }
                    
                }
            }
        }
     
         
        
      
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if rememberMeBtn.selectedSegmentIndex == 0 {
            guard let data =  try? JSONEncoder().encode(passwordTextField.text) else{return}
            //writeToKeyChain(dataToSave: data, account: userNameTextField.text!, service: "password")
            if doesKeyChainExist {
                writeToKeyChainUpdate(dataToSave: data, account: userNameTextField.text!, service: "password")
            }else {
                writeToKeyChain(dataToSave: data, account: userNameTextField.text!, service: "password")
            }
          
        }
        if let dest = segue.destination  as? UserViewController{
            dest.loadViewIfNeeded()
            dest.userName =  userNameTextField.text!
            dest.loadData()
        }
    }
    func writeToKeyChain(dataToSave : Data, account: String, service:String){
        let query = [
            kSecClass:kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecValueData: dataToSave
        ] as CFDictionary
        
        SecItemAdd(query,nil)
        doesKeyChainExist = true
    }
    func writeToKeyChainUpdate(dataToSave : Data, account: String, service:String){
        let query = [
            kSecClass:kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecValueData: dataToSave
        ] as CFDictionary
        SecItemUpdate(query,[kSecValueData:dataToSave] as CFDictionary)
    }
    func readFromPlist() -> [String : Any]? {
        
        guard let resourcePath = Bundle.main.resourcePath else { return nil }
        let fileURL =  URL(fileURLWithPath: resourcePath).appendingPathComponent("custom.plist")
        
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        
        guard let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String : Any] else { return nil }
        print(plist)
        return plist
    }
    
    func readFromKeyChain(service:String, account: String){
        let query = [
            kSecClass:kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: true,
            kSecReturnAttributes: true
        ] as CFDictionary
        
        var result : CFTypeRef?
        let status = SecItemCopyMatching(query, &result)
        
        if status == errSecSuccess {
            if let result = result as? [CFString : Any] {
                if let data = result[kSecValueData] as? Data {
                    let userName = result[kSecAttrAccount]
                    userNameTextField.text = userName as? String
                    let password = try? JSONDecoder().decode(String.self, from: data)
                    passwordTextField.text = password
                }
            }
        }
        
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        if userNameTextField.text ==  "admin" && passwordTextField.text == "admin" {
           performSegue(withIdentifier: "homePage", sender: nil)
            
           // self.navigationController?.pushViewController(ViewController(), animated: true)
        }else{
            guard let userName = userNameTextField.text, let password = passwordTextField.text else {return}
            let result = UserDataModel().authenticateUser(username: userName, password: password)
            if result == [] {
                print("Invalid Username/Password")
            }else{
                
                performSegue(withIdentifier: "userHomePage", sender: nil)
            }
        }
            
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
