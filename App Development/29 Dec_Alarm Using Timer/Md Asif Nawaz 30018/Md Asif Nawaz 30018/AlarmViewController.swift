//
//  AlarmViewController.swift
//  Md Asif Nawaz 30018
//
//  Created by BJIT on 29/12/22.
//

import UIKit
import AVFoundation

class AlarmViewController: UIViewController {

    @IBOutlet weak var snoozeLabel: UILabel!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var snoozeBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var circleImg: UIImageView!
    var delegate : ViewController?
    var timer = Timer()
    var seconds = 60
    //let audioUrl = URL(string: "/Users/bjit/Desktop/29%December/alarm.mp3")!
    
    var player = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeAlarmSound()
        bgView.backgroundColor = .clear
        bgView.isUserInteractionEnabled = true
        showAlarm()
        initializeLeftRightSwipeGesture()
    }
    
    @IBAction func stopBtnAction(_ sender: Any) {
        guard let delegate = delegate else{return}
        timer.invalidate()
        player.pause()
        delegate.isAlarmSet = false
        self.dismiss(animated: true)
    }
    
    @IBAction func snoozeBtnAction(_ sender: Any) {
        guard let delegate = delegate else{return}
        timer.invalidate()
        player.pause()
        delegate.performSnooze(pausedAtSecond: seconds)
        self.dismiss(animated: true)
        //self.showAlarm()
        
    }
    
    @IBAction func resetAlarmBtn(_ sender: Any) {
        guard let delegate = delegate else{return}
        timer.invalidate()
        player.pause()
        self.dismiss(animated: true)
        delegate.performSnoozeAndReset()
    }
    
    func initializeAlarmSound(){
        let audioPath = Bundle.main.path(forResource: "alarm", ofType: "mp3")
        let audioUrl = URL(fileURLWithPath: audioPath!)

        do {
            player = try AVAudioPlayer(contentsOf: audioUrl)
            //player.play()
        } catch {
            print("Error")
        }
    }
    
    func showAlarm(){
          timer =  Timer.scheduledTimer(withTimeInterval: 1, repeats: true){[weak self] _ in
              guard let self =  self, let delegate = self.delegate else {return}
              
              if (self.seconds<0){
                self.timer.invalidate()
                self.dismiss(animated: true)
                delegate.isAlarmSet = false
                return
              }
            
              self.player.play()
              self.snoozeLabel.text = "Alarm Dismissing in \(self.seconds) s"
              self.seconds = self.seconds - 1
        }
    }
     
    override func viewDidAppear(_ animated: Bool) {
        //let roateOptions = UIView.AnimationOptions[.curveLinear]
        super.viewDidAppear(animated)
        let _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear, .repeat], animations: { [weak self] in
                
                guard let self = self else {return}

           
                self.circleImg.transform = self.circleImg.transform.rotated(by: CGFloat.pi/4)
            
            })
            
        }
        UIView.animate(withDuration: 3, delay: 0, options: [.curveEaseInOut, .autoreverse, .repeat], animations: { [weak self] in
            guard let self = self else {return}
            self.circleImg.bounds.size.width *= 1.5
            self.circleImg.bounds.size.height *= 1.5
        }, completion: nil)
      
    }
    func initializeLeftRightSwipeGesture(){
        
        let leftSwipeGesture =  UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipeGesture.direction = .left
       
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipeGesture.direction = .right
        
        bgView.addGestureRecognizer(leftSwipeGesture)
        bgView.addGestureRecognizer(rightSwipeGesture)
    }
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer){
        
        if sender.direction == .left {
           stopBtnAction(self)
        }else if sender.direction == .right  {
            snoozeBtnAction(self)
        }
        
    }
}
