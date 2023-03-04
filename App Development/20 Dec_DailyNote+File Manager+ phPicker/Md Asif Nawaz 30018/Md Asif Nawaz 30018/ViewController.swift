//
//  ViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 20/12/22.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var fileTextLabel: UILabel!
    @IBOutlet weak var appendButton: UIButton!
    
    @IBOutlet weak var fileAllTextLabel: UITextView!
    let fileManager = FileManager.default
    var documentURL : URL? {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            return url
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readWriteImage(folderUrlStr:"Folder_1/Folder_2/Images", fileName: "cat3.png")

    }

    @IBAction func appendBtn(_ sender: Any) {
        createTextFile (folderUrlStr:"Folder_1/Folder_2")
    }
    
    func readWriteImage(folderUrlStr: String, fileName: String){
        //let fileManager = FileManager.default
        //guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
        
        guard let documentURL = documentURL else {return}
        let folderURL = documentURL.appendingPathComponent(folderUrlStr)
        
        do {
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
        }catch {
            print(error)
        }
        let imageDataToSave = UIImage(named: "cat3")?.pngData()
        
        let fileName = fileName
        let fileURL = folderURL.appendingPathComponent(fileName)
        print(fileURL)
        fileManager.createFile(atPath: fileURL.path, contents: imageDataToSave)
        img.image = UIImage(contentsOfFile: fileURL.path)
        
    }
    func createTextFile (folderUrlStr: String){
        //let fileManager = FileManager.default
        //guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
        
        guard let documentURL = documentURL else {return}
        let folderURL = documentURL.appendingPathComponent(folderUrlStr)
        
        do {
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
        }catch {
            print(error)
        }
        print(folderURL)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
        let uid = UUID().uuidString.prefix(5)
        let fileName: String =  dateFormatter.string(from: date) + "_\(uid)" + ".txt"
        let fileURL = folderURL.appendingPathComponent(fileName)
        
        let textToAppend = textField.text
        let textToData = textToAppend?.data(using: .utf8)
        fileManager.createFile(atPath: fileURL.path, contents: textToData)
        
        do{
            let readData = try Data(contentsOf: fileURL)
            let readDataStr = String(data: readData, encoding: .utf8)
            guard let readDataStr = readDataStr else{return}
            fileTextLabel.text = fileName
            fileAllTextLabel.text = readDataStr
        }catch {
            print(error)
        }
    }

}

