//
//  GalleryTableViewCollectionViewVC.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 13/12/22.
//

import UIKit

class GalleryTableViewCollectionViewVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate =  self
        tableView.dataSource =  self
        //var dataPass  = NestedCollectionTableViewCell()
    }
    
    }

extension GalleryTableViewCollectionViewVC : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ViewController.albumNameList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.h = ViewController.albumNameList[indexPath.section]
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         "Camera"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
extension GalleryTableViewCollectionViewVC : UITableViewDelegate {
    
}
