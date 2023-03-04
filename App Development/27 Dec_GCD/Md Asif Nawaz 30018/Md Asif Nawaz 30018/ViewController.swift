//
//  ViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 27/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableOneLabel: UILabel!
    @IBOutlet weak var tableTwoLabel: UILabel!
    @IBOutlet weak var tableThreeLabel: UILabel!
    @IBOutlet weak var tableFourLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    let colors: [UIColor] = [.systemRed,.systemBrown,.systemOrange,.systemYellow,.systemGreen]
    enum SyncAsyncEnum {
       case synchronization
       case asynchronization
    }
    let customMainSerialQueue =  DispatchQueue(label: "com.custom-main-serial")
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progressViewStyle = .bar
        // Do any additional setup after loading the view.
    }

    @IBAction func serveFoodBtn(_ sender: Any) {
        showActionSheet ()
    }
    func performGlobalConcurrentQueueSync (){
       // let customMainSerialQueue =  DispatchQueue(label: "com.custom-serial")
        let globalConcurrentQueue = DispatchQueue.global()
        customMainSerialQueue.async {[weak self] in
            guard let self = self else {return}
            self.doTask(queue: globalConcurrentQueue, enumValue: .synchronization, uiLabel: self.tableOneLabel)
            self.doTask(queue: globalConcurrentQueue, enumValue: .synchronization, uiLabel: self.tableTwoLabel)
            self.doTask(queue: globalConcurrentQueue, enumValue: .synchronization, uiLabel: self.tableThreeLabel)
            self.doTask(queue: globalConcurrentQueue, enumValue: .synchronization, uiLabel: self.tableFourLabel)
        }
        
    }
    func performGlobalConcurrentQueueAsync (){
        //let customMainSerialQueue =  DispatchQueue(label: "com.custom-serial")
        let globalConcurrentQueue = DispatchQueue.global()
        customMainSerialQueue.async {[weak self] in
            guard let self = self else {return}
            self.doTask(queue: globalConcurrentQueue, enumValue: .asynchronization, uiLabel: self.tableOneLabel)
            self.doTask(queue: globalConcurrentQueue, enumValue: .asynchronization, uiLabel: self.tableTwoLabel)
            self.doTask(queue: globalConcurrentQueue, enumValue: .asynchronization, uiLabel: self.tableThreeLabel)
            self.doTask(queue: globalConcurrentQueue, enumValue: .asynchronization, uiLabel: self.tableFourLabel)
        }
    }
    func performCustomQueueSerialSync (){
        //let customMainSerialQueue =  DispatchQueue(label: "com.custom-main-serial")
        let customQueueSerial = DispatchQueue(label: "com.custom-serial")
        customMainSerialQueue.async {[weak self] in
            guard let self = self else {return}
            self.doTask(queue: customQueueSerial, enumValue: .synchronization, uiLabel: self.tableOneLabel)
            self.doTask(queue: customQueueSerial, enumValue: .synchronization, uiLabel: self.tableTwoLabel)
            self.doTask(queue: customQueueSerial, enumValue: .synchronization, uiLabel: self.tableThreeLabel)
            self.doTask(queue: customQueueSerial, enumValue: .synchronization, uiLabel: self.tableFourLabel)
        }
    }
    func performCustomQueueSerialAsync (){
        let customQueueSerial = DispatchQueue(label: "com.custom-serial")
        customMainSerialQueue.async {[weak self] in
            guard let self = self else {return}
            self.doTask(queue: customQueueSerial, enumValue: .asynchronization, uiLabel: self.tableOneLabel)
            self.doTask(queue: customQueueSerial, enumValue: .asynchronization, uiLabel: self.tableTwoLabel)
            self.doTask(queue: customQueueSerial, enumValue: .asynchronization, uiLabel: self.tableThreeLabel)
            self.doTask(queue: customQueueSerial, enumValue: .asynchronization, uiLabel: self.tableFourLabel)
        }
    }
    func performCustomQueueConcurrent(){
        //let customMainSerialQueue =  DispatchQueue(label: "com.custom-main-serial")
        let customQueueConcurrent = DispatchQueue(label: "com.custom-Concurrent", attributes: .concurrent)
        customMainSerialQueue.async {[weak self] in
            guard let self = self else {return}
            self.doTask(queue: customQueueConcurrent, enumValue: .asynchronization, uiLabel: self.tableOneLabel)
            self.doTask(queue: customQueueConcurrent, enumValue: .asynchronization, uiLabel: self.tableTwoLabel)
            self.doTask(queue: customQueueConcurrent, enumValue: .asynchronization, uiLabel: self.tableThreeLabel)
            self.doTask(queue: customQueueConcurrent, enumValue: .asynchronization, uiLabel: self.tableFourLabel)
        }
    }
    func doTask(queue : DispatchQueue, enumValue: SyncAsyncEnum, uiLabel: UILabel){
        if enumValue ==  .synchronization {
            queue.sync {
                var percentage = 0
                for i in 0...4{
                    let rand = UInt32.random(in: 1...3)
                    sleep(rand)
                    DispatchQueue.main.async {[weak self] in
                        guard let self = self else {return}
                        uiLabel.text = "Serving Food \(percentage)% done"
                        uiLabel.backgroundColor = self.colors[i]
                        percentage = percentage + 25
                        self.progressView.progress += 0.05
                    }
                }
            }
        }else{
            queue.async {
                var percentage = 0
                for i in 0...4{
                    let rand = UInt32.random(in: 1...3)
                    sleep(rand)
                    DispatchQueue.main.async {[weak self] in
                        guard let self = self else {return}
                        uiLabel.text = "Serving Food \(percentage)% done"
                        uiLabel.backgroundColor = self.colors[i]
                        percentage = percentage + 25
                        self.progressView.progress += 0.05
                    }
                }
            }
        }
    }
    func showActionSheet (){
     
        let actionSheet = UIAlertController(title: "Action Sheet", message: "Choose an option", preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "Global Concurrent Queue - Sync", style: .default){[weak self]_ in
            guard let self = self else { return}
            self.intializeLables()
            self.performGlobalConcurrentQueueSync ()
        }
        let option2 = UIAlertAction(title: "Global Concurrent Queue - Async", style: .default){[weak self]_ in
            guard let self = self else { return}
            self.intializeLables()
            self.performGlobalConcurrentQueueAsync ()
        }
        let option3 = UIAlertAction(title: "Custom Serial Queue - Sync", style: .default){[weak self]_ in
            guard let self = self else { return}
            self.intializeLables()
            self.performCustomQueueSerialSync()
        }
        let option4 = UIAlertAction(title: "Custom Serial Queue - Async", style: .default){[weak self]_ in
            guard let self = self else { return}
            self.intializeLables()
            self.performCustomQueueSerialAsync()
        }
        let option5 = UIAlertAction(title: "Custom Concurrent Queue - Async", style: .default){[weak self]_ in
            guard let self = self else { return}
            self.intializeLables()
            self.performCustomQueueConcurrent()
        }
        let option6 = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(option1)
        actionSheet.addAction(option2)
        actionSheet.addAction(option3)
        actionSheet.addAction(option4)
        actionSheet.addAction(option5)
        actionSheet.addAction(option6)
        present(actionSheet, animated: true)
    }
    
    func intializeLables(){
        //customMainSerialQueue.suspend()
        tableOneLabel.text = "Table - 1"
        tableOneLabel.backgroundColor = .clear
        tableTwoLabel.text = "Table - 2"
        tableTwoLabel.backgroundColor = .clear
        tableThreeLabel.text = "Table - 3"
        tableThreeLabel.backgroundColor = .clear
        tableFourLabel.text = "Table - 4"
        tableFourLabel.backgroundColor = .clear
        progressView.progress = 0
    }
}

