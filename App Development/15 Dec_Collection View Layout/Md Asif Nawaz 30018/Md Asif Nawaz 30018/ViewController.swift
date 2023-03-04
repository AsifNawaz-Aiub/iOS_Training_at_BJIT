//
//  ViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 15/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let sectionLeftRightPadding: CGFloat = 40
    let interItemSpacing: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
       
        createLayout()
//        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
//        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
//
//        largeItem.contentInsets = insets
//
//
        

//
//        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/2))
//        let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [largeItem, verticalGroup, verticalGroup])
//
//        let section = NSCollectionLayoutSection(group: outerGroup)
//
//        let compositionalLayout = UICollectionViewCompositionalLayout(section: section)
//
//        collectionView.collectionViewLayout = compositionalLayout
    }

    func createLayout (){
        let insets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let itemOfSingleItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let itemOfSingleItemGroup = NSCollectionLayoutItem(layoutSize: itemOfSingleItemGroupSize)
        itemOfSingleItemGroup.contentInsets = insets
        let singleItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
        let singleItemGroup = NSCollectionLayoutGroup.vertical(layoutSize: singleItemGroupSize, subitems: [itemOfSingleItemGroup])
     
        //singleItemGroup.contentInsets = insets
        let itemOfPairItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2))
        let itemOfPairItemGroup =  NSCollectionLayoutItem(layoutSize: itemOfPairItemGroupSize)
        itemOfPairItemGroup.contentInsets = insets
        let pairItemGroupSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
        let pairItemGroup = NSCollectionLayoutGroup.vertical(layoutSize: pairItemGroupSize, subitems: [itemOfPairItemGroup,itemOfPairItemGroup])
        
       
        //pairItemGroup.contentInsets = insets
        
        let firstChildOutterGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/3))
        let childOutterGroup = NSCollectionLayoutGroup.horizontal(layoutSize: firstChildOutterGroupSize, subitems: [singleItemGroup,pairItemGroup])
        
        
        let itemOfQuadItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1))
        let itemOfQuadItemGroup = NSCollectionLayoutItem(layoutSize: itemOfQuadItemGroupSize)
        itemOfQuadItemGroup.contentInsets = insets
        let quadItemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))
        let quadItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: quadItemGroupSize, subitems: [itemOfQuadItemGroup,itemOfQuadItemGroup,itemOfQuadItemGroup,itemOfQuadItemGroup])
      
        //quadItemGroup.contentInsets = insets
        let parrentGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(3/4))
        let parrentGroup = NSCollectionLayoutGroup.vertical(layoutSize: parrentGroupSize, subitems: [childOutterGroup,quadItemGroup])
        
        let section = NSCollectionLayoutSection(group: parrentGroup)
        let compositionalLayout = UICollectionViewCompositionalLayout(section: section)
        
        collectionView.collectionViewLayout = compositionalLayout

        
    }

}

extension ViewController : UICollectionViewDelegate {
    
}
extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Pets.petList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        aCollectionViewCell.nibImage.image = UIImage(named: Pets.petList[indexPath.row].imageId)
        aCollectionViewCell.nibLabel.text = String(indexPath.row)
        
        return aCollectionViewCell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let numberOfCellsInSection: CGFloat = 3
//        let availableWidth = (collectionView.bounds.width) - (sectionLeftRightPadding * 2) - (interItemSpacing * (numberOfCellsInSection - 1))
//
//        let cellDimension = availableWidth/numberOfCellsInSection
//
//        return CGSize(width: cellDimension, height: cellDimension)
//
//        //return CGSize(width: 300, height: 300)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return interItemSpacing
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: sectionLeftRightPadding, bottom: 10, right: sectionLeftRightPadding)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 50
//    }
    
    
}
