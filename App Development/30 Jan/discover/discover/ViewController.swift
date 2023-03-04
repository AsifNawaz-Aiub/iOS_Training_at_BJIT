//
//  ViewController.swift
//  discover
//
//  Created by BJIT on 30/1/23.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        //print("REF - \(ref)")
        
        //ref.child("users").childByAutoId().setValue("T - 30019")
        
        getData()
        // Do any additional setup after loading the view.
    }

    func getData(){
        let ref = Database.database().reference().child("users")
        ref.observe(.value) { (snapshot) in
            print("S1 \(snapshot)")
            if let data = snapshot.value as?  [String:Any] {
              print("S2 \(data)")
              print("Your Real Time Id - \(data)")
          }
        }

    }
}

