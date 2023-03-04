//
//  GalleryCollectionViewController.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 12/12/22.
//

import UIKit

class GalleryCollectionViewController: UIViewController {

    @IBOutlet weak var galleryCollection: UICollectionView!
    
    var imageListCount: Int = 0
    var dbObjectToLoad : AnyObject = [] as AnyObject
    
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryCollection.delegate = self
        galleryCollection.dataSource =  self
        
        let galleryCollectionViewCellNib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        galleryCollection.register(galleryCollectionViewCellNib, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
        let headerFooterNib = UINib(nibName: "GalleryCollectionReusableView", bundle: nil)
        galleryCollection.register(headerFooterNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GalleryCollectionReusableView")
        galleryCollection.register(headerFooterNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "GalleryCollectionReusableView")
        let layout = UICollectionViewFlowLayout()

               layout.itemSize = CGSize(width: 90, height: 90)
               layout.scrollDirection = .vertical

        galleryCollection.collectionViewLayout = layout
               
        // Do any additional setup after loading the view.
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

extension GalleryCollectionViewController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dbObjectToLoad.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = galleryCollection.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        if let dbObjectToLoad = dbObjectToLoad as? [CameraImages]
        {
            item.img.image = UIImage(named: dbObjectToLoad[indexPath.row].imageId)
            item.imgLabel.text = dbObjectToLoad[indexPath.row].name
        }
        if let dbObjectToLoad = dbObjectToLoad as? [PicturesImages]
        {
            item.img.image = UIImage(named: dbObjectToLoad[indexPath.row].imageId)
            item.imgLabel.text = dbObjectToLoad[indexPath.row].name
        }
        return item
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = galleryCollection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GalleryCollectionReusableView", for: indexPath) as! GalleryCollectionReusableView
            if let _ = dbObjectToLoad as? [CameraImages]
            {
                header.headerFooterLabel.text = ViewController.albumNameList[0]
            }
            if let _ = dbObjectToLoad as? [PicturesImages]
            {
                header.headerFooterLabel.text = ViewController.albumNameList[1]
            }
            header.backgroundColor = .yellow
            return header
        }else {
            let footer = galleryCollection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GalleryCollectionReusableView", for: indexPath) as! GalleryCollectionReusableView
            footer.headerFooterLabel.text = " (C) Copyright iOS Gallery"
            footer.backgroundColor = .yellow
            return footer
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 38)
    }
}

extension GalleryCollectionViewController : UICollectionViewDelegate {
    
}

extension GalleryCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView( collectionView: UICollectionView, layoutcollectionViewLayout: UICollectionViewLayout, sizeForItemAtindexPath: IndexPath)->CGSize
    {
        return CGSize (width: 200, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}









