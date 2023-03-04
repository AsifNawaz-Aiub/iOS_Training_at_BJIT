//
//  SecondViewController.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 2/12/22.
//

import UIKit

class SecondViewController: UIViewController {

    var delegateFirstVC: ChangeImageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func greenButtonAction(_ sender: Any) {
        delegateFirstVC?.changeImage(to: UIImage(named: "green")!)
            self.dismiss(animated: true)
    }
    
    @IBAction func blackButtonAction(_ sender: Any) {
        delegateFirstVC?.changeImage(to: UIImage(named: "black2")!)
            self.dismiss(animated: true)
    }
    
  

}
