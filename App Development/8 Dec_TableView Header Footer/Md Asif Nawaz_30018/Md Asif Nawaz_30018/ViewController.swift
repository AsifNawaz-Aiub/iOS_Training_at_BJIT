//
//  ViewController.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 8/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource =  self
        let customHeaderNib = UINib (nibName: "CustomHeaderOfTableView", bundle: nil)
        tableView.register(customHeaderNib, forHeaderFooterViewReuseIdentifier: "CustomHeaderOfTableView")
        let customFooterNib = UINib(nibName: "CustomFooterOfTableView", bundle: nil)
        tableView.register(customFooterNib, forHeaderFooterViewReuseIdentifier: "CustomFooterOfTableView")
    }


}
extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header =  tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderOfTableView") as? CustomHeaderOfTableView
        header?.bgView.backgroundColor = .yellow
        header?.headerLabel.text = "Animals"
        header?.headerImage.image = UIImage (named: "animals")
        return header
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         return 30
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomFooterOfTableView")
        return footer
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath)
        cell.textLabel?.text = "Pet Animals"
        cell.detailTextLabel?.text = "Cat, Dog, Hamster"
        return cell
    }
    
    
}
extension ViewController : UITableViewDelegate {
    
}
