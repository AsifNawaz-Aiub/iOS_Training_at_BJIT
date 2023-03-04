//
//  ViewController.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 30/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func appendButton(_ sender: Any) {
        if let _ = textField.text, let _ = label.text {
            label.text! = label.text! + textField.text!
        }
    }
    
    @IBAction func clearButton(_ sender: Any) {
        label.text = ""
    }
}

