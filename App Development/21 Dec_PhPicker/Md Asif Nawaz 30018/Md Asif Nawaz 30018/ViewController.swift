//
//  ViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 19/12/22.
//

import UIKit
import PhotosUI
class ViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var twoBytwoBtn: UIButton!
    @IBOutlet weak var oneByTwoBtn: UIButton!
    
    var images = ["cat1","cat1","cat1","cat1","cat1","cat1","cat1","cat1","cat1","cat1","cat1","cat1","cat1","cat1","cat1",]
    var uiImages : [UIImage] = []
    var toogleImagePicker : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 100, height: 100)
//        layout.scrollDirection = .vertical
//        collectionView.collectionViewLayout = layout
        for image in images {
            uiImages.append(UIImage(named: image)!)
        }
       
        collectionView.collectionViewLayout = layoutOne()
    }

    @IBAction func addImageBtn(_ sender: Any) {
        
        if toogleImagePicker{
            showPHPickerImages()
        }
        else {
            showImagePicker()
        }
        toogleImagePicker = !toogleImagePicker
    }
    @IBAction func twoByTwoGridBtn(_ sender: Any) {
        
        twoBytwoBtn.isUserInteractionEnabled = false
        oneByTwoBtn.isUserInteractionEnabled = false
        collectionView.startInteractiveTransition(to: layoutOne()){[weak self]_,_ in
            
            guard let self = self else {return}
            self.twoBytwoBtn.isUserInteractionEnabled = true
            self.oneByTwoBtn.isUserInteractionEnabled = true
        }
        collectionView.finishInteractiveTransition()
    }
    
    @IBAction func oneByTwoGridBtn(_ sender: Any) {
        twoBytwoBtn.isUserInteractionEnabled = false
        oneByTwoBtn.isUserInteractionEnabled = false
        collectionView.startInteractiveTransition(to: layoutTwo()){[weak self]_,_ in
            guard let self = self else {return}
            self.twoBytwoBtn.isUserInteractionEnabled = true
            self.oneByTwoBtn.isUserInteractionEnabled = true
        }
        collectionView.finishInteractiveTransition()
    }
    func showImagePicker(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            present(imagePicker, animated: true)
        }
    }
    func showPHPickerImages (){
        var phPickerConfig = PHPickerConfiguration()
        phPickerConfig.selectionLimit = 5
        phPickerConfig.filter = .images
        let phPicker = PHPickerViewController(configuration: phPickerConfig)
        phPicker.delegate = self
        present(phPicker, animated: true)
    }
    func layoutOne () -> UICollectionViewCompositionalLayout {
        let inset = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let itemOfLayoutOneSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
        let itemOfLayoutOne = NSCollectionLayoutItem(layoutSize: itemOfLayoutOneSize)
        itemOfLayoutOne.contentInsets = inset
        let groupOfLayoutOneSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/5))
        let groupOfLayoutOne = NSCollectionLayoutGroup.horizontal(layoutSize: groupOfLayoutOneSize, subitems: [itemOfLayoutOne,itemOfLayoutOne])
        let section = NSCollectionLayoutSection(group: groupOfLayoutOne)
        let layoutOne = UICollectionViewCompositionalLayout (section: section)
        
        return layoutOne
    }
    
    func layoutTwo () -> UICollectionViewCompositionalLayout {
        let inset = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        let itemOfLayoutTwoSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemOfLayoutTwo = NSCollectionLayoutItem(layoutSize: itemOfLayoutTwoSize)
        itemOfLayoutTwo.contentInsets = inset
        
        let groupOfLayoutTwoSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))
        let groupOfLayoutTwo = NSCollectionLayoutGroup.horizontal(layoutSize: groupOfLayoutTwoSize, subitems: [itemOfLayoutTwo])
        let section = NSCollectionLayoutSection(group: groupOfLayoutTwo)
        let layoutOne = UICollectionViewCompositionalLayout (section: section)
        
        return layoutOne
    }
    func writeImage(folderUrlStr: String, fileName: String, imageToSave: UIImage){
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
        
        let folderURL = documentURL.appendingPathComponent(folderUrlStr)
        
        do {
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
        }catch {
            print(error)
        }
        let imageDataToSave = imageToSave.pngData()
        
       
        print(folderURL)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
        let uid = UUID().uuidString.prefix(5)
        let modifiedFileName: String =  dateFormatter.string(from: date) + "_\(uid)" + fileName
        let fileURL = folderURL.appendingPathComponent(modifiedFileName)
        print(fileURL)
        fileManager.createFile(atPath: fileURL.path, contents: imageDataToSave)
        //img.image = UIImage(contentsOfFile: fileURL.path)
        
    }
    func showActionSheet(row:Int){
    
        let actionSheet =  UIAlertController(title: "Action Sheet!", message: "Choose an option", preferredStyle: .actionSheet)
        let saveOption = UIAlertAction(title: "Save", style: .default, handler: {[weak self] _ in
            guard let self = self else {return}
            let image = self.uiImages[row]
            self.writeImage(folderUrlStr: "Images", fileName: ".png", imageToSave: image)
        })
        actionSheet.addAction(saveOption)
        let cancelOption = UIAlertAction(title: "Cancel", style: .default)
        actionSheet.addAction(cancelOption)
        present(actionSheet, animated: true, completion: nil)
    }
    
   

}
 
extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showActionSheet(row: indexPath.row)
    }
    
}

extension ViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return uiImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as! CustomCollectionViewCell
        cell.img.image = uiImages[indexPath.row]
        return cell
    }
    
    
}
extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.uiImages.append(image)
        }
        self.collectionView.reloadData()
        picker.dismiss(animated: true)
    }
}

extension ViewController : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) {[weak self] image,error in
                guard let self = self else {return}
                if let image = image as? UIImage {
                    self.uiImages.append(image)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
               
            }
        }
        picker.dismiss(animated: true)
    }
    
    
    
}
