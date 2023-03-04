//
//  ViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 19/12/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var twoBytwoBtn: UIButton!
    @IBOutlet weak var oneByTwoBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 100, height: 100)
//        layout.scrollDirection = .vertical
//        collectionView.collectionViewLayout = layout
        
       
        collectionView.collectionViewLayout = layoutOne()
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

}

extension ViewController : UICollectionViewDelegate {
    
}

extension ViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as! CustomCollectionViewCell
        cell.img.image = UIImage(named: "cat1")
        return cell
    }
    
    
}
