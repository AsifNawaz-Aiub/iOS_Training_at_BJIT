//
//  ViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 29/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var tickImage: UIImageView!
    @IBOutlet weak var tickImageVerticalCon: NSLayoutConstraint!
    var isAlarmSet = false
    var isSnoozing =  false
    var pausedAtSecond = 0
    var alarmTimeList : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVc = segue.destination as? AlarmViewController{
            destinationVc.loadViewIfNeeded()
            destinationVc.delegate = self
            if isSnoozing{
                destinationVc.seconds = pausedAtSecond
                isSnoozing = false
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tickImageVerticalCon.constant -= view.bounds.width
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    @objc func updateTime() {
    
      let date = Date()

      let formatter = DateFormatter()
      formatter.dateStyle = .none
      formatter.timeStyle = .medium
      
      let currentTimeString = formatter.string(from: date)
      let alarmTimeString = formatter.string(from: timePicker.date)
      currentTime.text = currentTimeString
       if (alarmTimeString == currentTimeString && isAlarmSet == true ){
            performSegue(withIdentifier: "showAlarm", sender: self)
        }
    }
    
    @IBAction func setTime(_ sender: Any) {
        isAlarmSet = true
        //let formatter = DateFormatter()
        //formatter.dateStyle = .none
        //formatter.timeStyle = .medium
        //let alarmTimeString = formatter.string(from: timePicker.date)
        //alarmTimeList.append(alarmTimeString)
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: { [weak self] in
           
            self?.tickImageVerticalCon.constant = 0
            self?.view.layoutIfNeeded()
            self?.tickImage.image = UIImage.gifImageWithName("t3")
        }, completion: {[weak self] _ in
            UIView.animate(withDuration: 1, delay: 2, options: [], animations: { [weak self] in
               self?.tickImageVerticalCon.constant -= self!.view.bounds.width
               self?.view.layoutIfNeeded()
            }, completion: nil)
        })
      
        //performSegue(withIdentifier: "showAlarm", sender: self)
    }
  
    func performSnoozeAndReset(){
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + .seconds(5)) { [weak self] in
            guard let self =  self else {return}
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showAlarm", sender: self)
            }
        }
    }
    

    func performSnooze(pausedAtSecond : Int){
        isSnoozing = true
        if (pausedAtSecond < 10){
            self.pausedAtSecond = 10
        }else{
            self.pausedAtSecond = pausedAtSecond
        }
       
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + .seconds(5)) { [weak self] in
            guard let self =  self else {return}
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showAlarm", sender: self)
             
            }
            
        }
               
    }

}





//    func show(){
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = .time
//
//        let actionSheet = UIAlertController(title: "Select Time", message: nil, preferredStyle: .actionSheet)
//        actionSheet.view.addSubview(datePicker)
//        let height: NSLayoutConstraint = NSLayoutConstraint(item: actionSheet.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 300)
//        actionSheet.view.addConstraint(height)
//        let pickerAction = UIAlertAction(title: "Select", style: .default) { _ in
//          // Add the date picker to the action sheet
//
//        }
//
//        actionSheet.addAction(pickerAction)
//
//        let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
//          // Read the selected time from the date picker and do something with it
//          let selectedTime = datePicker.date
//          print("Selected time: \(selectedTime)")
//
//          // Dismiss the action sheet
//          actionSheet.dismiss(animated: true, completion: nil)
//        }
//        actionSheet.addAction(doneAction)
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        actionSheet.addAction(cancelAction)
//
//        present(actionSheet, animated: true, completion: nil)
//
//    }

//    func initializeGif (){
//        //
//       // let gifData =  try! Data(contentsOf: URL(string: "https://icons8.com/icon/CIdgkSn4RFPP/checkmark")!)
//        let gifURL = URL(string: "https://icons8.com/icon/CIdgkSn4RFPP/checkmark")!
//        let imageSource = CGImageSourceCreateWithURL(gifURL as CFURL, nil)!
//        let imageCount = CGImageSourceGetCount(imageSource)
//        var images = [UIImage]()
//        for i in 0..<imageCount {
//            let image = CGImageSourceCreateImageAtIndex(imageSource, i, nil)!
//            images.append(UIImage(cgImage: image))
//        }
//        let gifImage =  UIImage.animatedImage(with: images, duration: 1)
//        tickImage.image = gifImage
//    }
