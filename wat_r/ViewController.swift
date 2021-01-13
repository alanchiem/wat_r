//
//  ViewController.swift
//  wat_r
//
//  Created by Alan Chiem on 1/12/21.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var OurTimer = Timer()
    var timerDisplayed = 0
    
    
    
    @IBAction func StartBTN(_ sender: Any) {
        OurTimer = Timer.scheduledTimer(timeInterval: 1,
                                        target: self,
                                        selector: #selector(Action),
                                        userInfo: nil,
                                        repeats: true)
    }
    
    
    @IBAction func PauseBTN(_ sender: Any) {
        OurTimer.invalidate()
    }
    
    
    
    @IBAction func ResetBTN(_ sender: Any) {
        OurTimer.invalidate()
        timerDisplayed = 0
        Label.text = "0"
    }
    
    
    @objc func Action() {
        timerDisplayed += 1
        Label.text = String(timerDisplayed)
    }
    
    
    @IBOutlet weak var Label: UILabel!
    

    override func viewDidLoad() {
        
    }
}
