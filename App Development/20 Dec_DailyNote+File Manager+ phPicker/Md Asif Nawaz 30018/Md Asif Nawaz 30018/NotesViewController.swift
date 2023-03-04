//
//  NotesViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 22/12/22.
//

import UIKit
import PhotosUI
struct Notes {
    
    var fileName : String = ""
    var fileContent : String = ""
    var attachedImage : UIImage = UIImage(named: "cat3")!
    
    static var noteList : [Notes] = []
}

class NotesViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var notesImage: UIImageView!
    @IBOutlet weak var browseImageBtn: UIButton!
    @IBOutlet weak var saveNoteBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getFileList ()
        tableView.reloadData()
        browseImageBtn.layer.cornerRadius = 10
        //browseImageBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
    }
    let notesFolderURL = "Notes"
    let notesImageFolderURL = "Notes Images"
    var isEditingNote : Bool =  false
    var editingFileUrl: URL!
    @IBAction func saveImage(_ sender: Any) {
      
        showPHPickerImages()
        
    }
    @IBAction func saveNote(_ sender: Any) {
        if textView.text == ""{return}
        if isEditingNote {
            editNote()
        }else{
            createTextFile(folderUrlStr: notesFolderURL)
        }
       
    }
    func getFileList (){
        Notes.noteList = []
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let folderURL = documentsDirectory.appendingPathComponent(notesFolderURL)
        do{
            let fileURLs = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            
            for fileURL in fileURLs {
                if fileURL.pathExtension == "txt" {
                    
                    let fileName = fileURL.lastPathComponent
                    let fileNameWithoutExtention = fileURL.lastPathComponent.components(separatedBy: ".")[0]
                    let readData = try Data(contentsOf: fileURL)
                    let readDataStr = String(data: readData, encoding: .utf8)
                    guard let readDataStr = readDataStr else{return}
                    let fileContents = readDataStr
                    //let attachedImage = UIImage(named: "cat3")!
                    let imgFolder = documentsDirectory.appendingPathComponent(notesImageFolderURL)
                    let imgFileName = fileNameWithoutExtention + ".png"
                    let imgFileUrl = imgFolder.appendingPathComponent(imgFileName)
                    let img = UIImage(contentsOfFile: imgFileUrl.path )
                    Notes.noteList.append(Notes(fileName: fileName, fileContent: fileContents, attachedImage: img!))
                    
                    print(fileName)
                }
                Notes.noteList = Notes.noteList.sorted(by: {
                    $1.fileName<$0.fileName
                })
            }
        } catch{
            print(error)
        }
      

    }
    func createTextFile (folderUrlStr: String){
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
        
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
        let fileName: String =  dateFormatter.string(from: date) + "_\(uid)"
        let fileURL = folderURL.appendingPathComponent(fileName + ".txt")
        
        let textToAppend = textView.text
        let textToData = textToAppend?.data(using: .utf8)
        fileManager.createFile(atPath: fileURL.path, contents: textToData)
        writeImage(folderUrlStr: notesImageFolderURL, fileName: fileName, image: notesImage.image!) // Needs to handle later
        
        
    }
    func writeImage(folderUrlStr: String, fileName: String, image: UIImage){
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
        
       
        let folderURL = documentURL.appendingPathComponent(folderUrlStr)
        
        do {
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
        }catch {
            print(error)
        }
        let imageDataToSave = image.pngData()
        
        //let fileName = fileName
        let fileURL = folderURL.appendingPathComponent(fileName + ".png")
        print(fileURL)
        fileManager.createFile(atPath: fileURL.path, contents: imageDataToSave)
        getFileList ()
        tableView.reloadData()
        textView.text = ""
        notesImage.image = UIImage(named: "default")
        //img.image = UIImage(contentsOfFile: fileURL.path)
        
    }
    func editNote(){
        do{
            try textView.text.write(to: editingFileUrl, atomically: true, encoding: .utf8)
            
        }catch{
            print(error)
        }
        isEditingNote = false
        textView.text = ""
        notesImage.image = UIImage(named: "default")
        saveNoteBtn.titleLabel?.text = "Save Note"
        getFileList ()
        tableView.reloadData()
    }
    
    func showPHPickerImages (){
        var phPickerConfig = PHPickerConfiguration()
        phPickerConfig.selectionLimit = 1
        phPickerConfig.filter = .images
        let phPicker = PHPickerViewController(configuration: phPickerConfig)
        phPicker.delegate = self
        present(phPicker, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: nil){ [weak self] _,_, completion in
            
            guard let self = self else{return}
            completion(true)
            let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
            self.handleEditAction(fileName: cell.fileName.text!, image: cell.img.image! ) // will handle later
        }
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor =  .systemYellow
        
        let swipeAction =  UISwipeActionsConfiguration (actions: [editAction])
        
        return swipeAction
        
    }
    
    func handleEditAction(fileName: String, image: UIImage){
        isEditingNote = true
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
        let fileUrl = documentURL.appendingPathComponent(notesFolderURL).appendingPathComponent(fileName)
        editingFileUrl = fileUrl
          do{
              let data = try Data(contentsOf: fileUrl)
              let dataStr = String(data: data, encoding: .utf8)
              textView.text = dataStr
              notesImage.image = image
              saveNoteBtn.titleLabel?.text = " Save"
             
          }catch{
             print(error)
          }
       
       
//        let editedText = textView.text

        
    }

}
extension NotesViewController : UITableViewDelegate {
    
}

extension NotesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notes.noteList.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "Notes"
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.fileName.text = Notes.noteList[indexPath.row].fileName
        cell.textView.text = Notes.noteList[indexPath.row].fileContent
        cell.img.image = Notes.noteList[indexPath.row].attachedImage
        
        return cell
    }
    
    
    
}
extension NotesViewController : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) {[weak self] image,error in
                guard let self = self else {return}
                if let image = image as? UIImage {
                    
                    DispatchQueue.main.async {
                        self.notesImage.image = image
                    }
                }
               
            }
        }
        picker.dismiss(animated: true)
    }
    
    
}

