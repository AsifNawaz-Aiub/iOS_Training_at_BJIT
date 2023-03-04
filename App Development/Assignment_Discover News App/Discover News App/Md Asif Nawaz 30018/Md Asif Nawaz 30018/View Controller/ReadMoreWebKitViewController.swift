//
//  ReadMoreWebKitViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 16/1/23.
//

import UIKit
import WebKit

class ReadMoreWebKitViewController: UIViewController {

    @IBOutlet weak var webKit: WKWebView!
    var urlString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: urlString){
            webKit.load( URLRequest(url: url))
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        super.viewWillDisappear(animated)
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
