//
//  ViewController.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 28/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelOutlet:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func redButton(_ sender: Any) {
        labelOutlet.text = "Red"
        labelOutlet.textColor = UIColor.red
    }
    
    @IBAction func blueButton(_ sender: Any) {
        labelOutlet.text = "Blue"
        labelOutlet.textColor = UIColor.blue
    }
    @IBAction func yellowButton(_ sender: Any) {
        labelOutlet.text = "Yellow"
        labelOutlet.textColor = UIColor.yellow
    }
    
}

