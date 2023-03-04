//
//  FirstViewController.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 2/12/22.
//

import UIKit

protocol ChangeImageDelegate {
    func changeImage (to Image : UIImage)
}

class FirstViewController: UIViewController, ChangeImageDelegate {

    
    @IBOutlet weak var imageOfFirstVC: UIImageView!
    @IBOutlet weak var chooseButtonOfFirstVC: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func changeImage(to image : UIImage){
        imageOfFirstVC.image = image
        chooseButtonOfFirstVC.setTitle("Change Side", for: UIControl.State.normal)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FirstToSecondVC"{
            if let destinationOfSecondVC = segue.destination as? SecondViewController{
                destinationOfSecondVC.delegateFirstVC = self
            }
        }
    }
    
}
