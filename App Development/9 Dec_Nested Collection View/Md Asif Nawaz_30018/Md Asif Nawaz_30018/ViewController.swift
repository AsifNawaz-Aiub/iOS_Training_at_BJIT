//
//  ViewController.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 9/12/22.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    static var albumNameList: [String] = ["Camera", "Pictures", "Work in this folder is not related to task, its extra practice"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GalleryCollectionViewController {
            let index = tableView.indexPathForSelectedRow
            if index?.row == 0 {
                destination.imageListCount = CameraImages.cameraImagesList.count
                destination.dbObjectToLoad = CameraImages.cameraImagesList as AnyObject
            } else if index?.row == 1 {
                destination.imageListCount = PicturesImages.PicturesImagesList.count
                destination.dbObjectToLoad = PicturesImages.PicturesImagesList as AnyObject
            }
        }
        if let _ = segue.destination as? GalleryTableViewCollectionViewVC {
            //let index = tableView.indexPathForSelectedRow
            NestedCollectionTableViewCell.imageListCount = CameraImages.cameraImagesList.count + PicturesImages.PicturesImagesList.count
            NestedCollectionTableViewCell.dbObjectToLoad = [CameraImages.cameraImagesList, PicturesImages.PicturesImagesList] as AnyObject
//            if index?.row == 0 {
//                NestedCollectionTableViewCell.imageListCount = CameraImages.cameraImagesList.count
//                NestedCollectionTableViewCell.dbObjectToLoad = CameraImages.cameraImagesList as AnyObject
//            } else if index?.row == 1 {
//                NestedCollectionTableViewCell.imageListCount = PicturesImages.PicturesImagesList.count
//                NestedCollectionTableViewCell.dbObjectToLoad = PicturesImages.PicturesImagesList as AnyObject
//            }
        }
    }
    
    func showEditAllert (indexPath : [IndexPath]){
        
        let tempValueToBeEdited = ViewController.albumNameList[indexPath[0].row]
        let editAlertVc = UIAlertController(title: "Edit Album Name", message: "Write your album name", preferredStyle: .alert)
        let editBtnAction = UIAlertAction(title: "Save", style: .default){[weak self] _ in
           
            guard let self = self else {return}
            //, let _ =  (editAlertVc.textFields), let _ = (editAlertVc.textFields![0].text)
            if (editAlertVc.textFields![0].text != ""){
                ViewController.albumNameList[indexPath[0].row] = editAlertVc.textFields![0].text ?? tempValueToBeEdited
                self.tableView.reloadData()
            }
        
            
        }
        editAlertVc.addAction(editBtnAction)
        editAlertVc.addTextField(){ textField in
            textField.text = tempValueToBeEdited
        }
        present(editAlertVc, animated: true)
//        { [weak self] in
//            guard let self = self else {return}
//            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlert))
//            editAlertVc.view.window?.addGestureRecognizer(gesture )
//        }
       
    }
//    @objc func dismissAlert(){
//        self.dismiss(animated: true)
//    }
   

}

extension ViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil){ [weak self] _,_, completion in
            
            guard let self = self else{return}
            completion(true)
            self.handleDeleteAction(indexPath : [indexPath])
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor =  .systemRed
        
        let swipeAction =  UISwipeActionsConfiguration (actions: [deleteAction])
        
        return swipeAction
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: nil) { [weak self] _,_, completion in
            guard let self =  self else {return}
            completion(true)
            self.handleEditAction(indexPath : [indexPath])
        }
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = .gray
        let leadingSwipeAction = UISwipeActionsConfiguration(actions: [editAction])
        return leadingSwipeAction
    }
    func handleDeleteAction (indexPath : [IndexPath]) {
        tableView.beginUpdates()
        tableView.deleteRows(at: indexPath , with: .bottom)
        ViewController.albumNameList.remove(at: indexPath[0].row)
        tableView.endUpdates()
        
    }
    func handleEditAction (indexPath : [IndexPath]) {
       
        showEditAllert(indexPath : indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Gallery"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.albumNameList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath)
        cell.textLabel!.text = ViewController.albumNameList[indexPath.row]
        return cell
    }
    
    
}

extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 || indexPath.row == 1 {
            performSegue(withIdentifier: "GalleryAlbumView", sender: self)
        }else {
            performSegue(withIdentifier: "ToGalleryTableViewCollectionViewVC", sender: self)
        }
    }
    
}
