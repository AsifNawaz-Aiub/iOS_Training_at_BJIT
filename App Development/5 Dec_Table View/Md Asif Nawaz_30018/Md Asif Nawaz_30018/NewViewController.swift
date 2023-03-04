//
//  ViewController.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 5/12/22.
//

import UIKit


struct Pets {
    var name : String
    var imageId : String
    var detailedText : String
    static var petList = [ Pets(name: "Cat 1", imageId: "cat1", detailedText: "The cat is a domestic animal. Its scientific name is Felis catus. It is a small animal that belongs to the “Felidae” family. The cat is the only domesticated species of the family. Other members include tigers, panthers, etc. Cats are adorable animals and are petted by lots of people in the world. They are playful and spending time with them reduces stress and anxiety. In this essay about cats in English, their nature, behaviour and diet have been discussed.The cat is a domestic animal. Its scientific name is Felis catus. It is a small animal that belongs to the “Felidae” family. The cat is the only domesticated species of the family. Other members include tigers, panthers, etc. Cats are adorable animals and are petted by lots of people in the world. They are playful and spending time with them reduces stress and anxiety. In this essay about cats in English, their nature, behaviour and diet have been discussed.The cat is a domestic animal. Its scientific name is Felis catus. It is a small animal that belongs to the “Felidae” family. The cat is the only domesticated species of the family. Other members include tigers, panthers, etc. Cats are adorable animals and are petted by lots of people in the world. They are playful and spending time with them reduces stress and anxiety. In this essay about cats in English, their nature, behaviour and diet have been discussed."),
                           Pets(name: "Cat 2", imageId: "cat2", detailedText: "The cat is a domestic animal. Its scientific name is Felis catus. It is a small animal that belongs to the “Felidae” family. The cat is the only domesticated species of the family. Other members include tigers, panthers, etc."),
                           Pets(name: "Cat 3", imageId: "cat3", detailedText: "The cat is a domestic animal. Its scientific name is Felis catus.")]
}
struct FarmAnimal {
    var name : String
    var detailedText : String
    static var farmAnimalList = [ FarmAnimal(name: "Cow", detailedText: "Its a Cow"),
                                  FarmAnimal(name: "Cow", detailedText: "Its a Cow"),
                                  FarmAnimal(name: "Cow", detailedText: "Its a Cow")]
}
struct WildAnimal {
    var name : String
    var detailedText : String
    static var wildAnimalList = [ FarmAnimal(name: "Tiger 1", detailedText: "Its a Tiger 1"),
                                  FarmAnimal(name: "Tiger 2", detailedText: "Its a Tiger 2"),
                                  FarmAnimal(name: "Tiger 3", detailedText: "Its a Tiger 3")]
}
class NewViewController: UIViewController {
    
    
    var aTuple : (UIImage, String)? = nil
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "CustomNibTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "customNibTableViewCell")
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "petDetailView"{
            if let destinationOfPetDetailView = segue.destination as? PetDetailModalVC{
                
                let index = tableView.indexPathForSelectedRow
               
                destinationOfPetDetailView.loadViewIfNeeded()
                
                destinationOfPetDetailView.petImage.image = UIImage(named : Pets.petList[index!.row].imageId)
            
                destinationOfPetDetailView.petDetail.text = Pets.petList[index!.row].detailedText
                
            }
        }
    }
    func loadPetDetail () -> ( UIImage, String)? {
        return aTuple
    }

}

extension NewViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return FarmAnimal.farmAnimalList.count
        }
        else if section == 1 {
            
            return WildAnimal.wildAnimalList.count
        }
        else if section == 2 {
            return Pets.petList.count
        }else{
            return Pets.petList.count
        }
   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //if tableView.ident
        if indexPath.section == 0 {
            let cellOne = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath)
            cellOne.textLabel?.text = FarmAnimal.farmAnimalList[indexPath.row].name
            cellOne.detailTextLabel?.text = FarmAnimal.farmAnimalList[indexPath.row].detailedText
            return cellOne
        }
        else if indexPath.section == 1 {
            let cellTwo = tableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath)
            cellTwo.textLabel?.text = WildAnimal.wildAnimalList[indexPath.row].name
            cellTwo.detailTextLabel?.text = WildAnimal.wildAnimalList[indexPath.row].detailedText
            return cellTwo
        }else if indexPath.section == 2 {
            let cellThree = tableView.dequeueReusableCell(withIdentifier: "cellThree", for: indexPath) as! CustomTableViewCell
            cellThree.petImage.image = UIImage(named: Pets.petList[indexPath.row].imageId )
            cellThree.petLabel.text = Pets.petList[indexPath.row].detailedText
            return cellThree
        }else{
            let cellfour = tableView.dequeueReusableCell(withIdentifier: "customNibTableViewCell", for: indexPath) as! CustomNibTableViewCell
            cellfour.customNibImage.image = UIImage(named: Pets.petList[indexPath.row].imageId )
            cellfour.customNibLabel.text = Pets.petList[indexPath.row].detailedText
            return cellfour
        }
        
        
    }
    
    
}

extension NewViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
           
            performSegue(withIdentifier: "petDetailView", sender: self)
        }
      
    }
    
}
