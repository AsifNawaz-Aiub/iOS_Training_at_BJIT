//
//  NestedCollectionTableViewCell.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 13/12/22.
//

import UIKit

class NestedCollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    static var imageListCount: Int = 0
    static var dbObjectToLoad : AnyObject = [] as AnyObject
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        let galleryCollectionViewCellNib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(galleryCollectionViewCellNib, forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension NestedCollectionTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if let dbObjectToLoad = NestedCollectionTableViewCell.dbObjectToLoad as? [CameraImages]
            {
                return dbObjectToLoad.count
                
            }
        if let dbObjectToLoad = NestedCollectionTableViewCell.dbObjectToLoad as? [PicturesImages]
            {
                return dbObjectToLoad.count
                
            }
            
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        if let dbObjectToLoad = NestedCollectionTableViewCell.dbObjectToLoad as? [CameraImages]
        {
            item.img.image = UIImage(named: dbObjectToLoad[indexPath.row].imageId)
            item.imgLabel.text = dbObjectToLoad[indexPath.row].name
        }
        if let dbObjectToLoad = NestedCollectionTableViewCell.dbObjectToLoad as? [PicturesImages]
        {
            item.img.image = UIImage(named: dbObjectToLoad[indexPath.row].imageId)
            item.imgLabel.text = dbObjectToLoad[indexPath.row].name
        }
      
        return item
        
    }
    
    
}
extension NestedCollectionTableViewCell : UICollectionViewDelegate {
    
}
