//
//  ViewController.swift
//  wat_r
//
//  Created by Alan Chiem on 1/12/21.
//

import UIKit
import Foundation
import Lottie

class ViewController: UIViewController {
    
    // For the water droplets counter
    var OurTimer = Timer()
    var timerDisplayed = 0
    var timerActivated = false
    var paused = true
    
    
    // For the stopwatch timer
    var stopWatch = Timer()
    var counter = 0
    
    
    // Animation
    let animationView = AnimationView()

    
    
    // Start button, starts the timer
    @IBAction func StartBTN(_ sender: Any) {
        if (timerActivated == false) {
            OurTimer = Timer.scheduledTimer(timeInterval: 2,
                                            target: self,
                                            selector: #selector(Action),
                                            userInfo: nil,
                                            repeats: true)
            
            stopWatch = Timer.scheduledTimer(timeInterval: 1,
                                             target: self,
                                             selector: #selector(timerCounter),
                                             userInfo: nil,
                                             repeats: true)
            
            timerActivated = true
            paused = false
        }
        
        else if (timerActivated == true)
        {
            // do nothing
            // wow this actually worked
        }
    }
    
    
    // Pause button, stops the timer
    @IBAction func PauseBTN(_ sender: Any) {
        if (paused == false) {
            OurTimer.invalidate()
            stopWatch.invalidate()
            animationView.pause()
            paused = true
            timerActivated = true
            PauseButton.setTitle("Play", for: UIControl.State.normal)
        }
        
        else if (paused == true && timerActivated == true) {
            // for the drops
            OurTimer = Timer.scheduledTimer(timeInterval: 2,
                                            target: self,
                                            selector: #selector(Action),
                                            userInfo: nil,
                                            repeats: true)
            
            // for the time
            stopWatch = Timer.scheduledTimer(timeInterval: 1,
                                             target: self,
                                             selector: #selector(timerCounter),
                                             userInfo: nil,
                                             repeats: true)
            
            animationView.play() // play animation
            paused = false // timer isn't paused
            PauseButton.setTitle("Pause", for: UIControl.State.normal)
        }
    }
    
    
    // Reset button, sets timer back to 0
    @IBAction func ResetBTN(_ sender: Any) {
        OurTimer.invalidate()
        timerActivated = false
        timerDisplayed = 0
        Label.text = "0"
        
        stopWatch.invalidate()
        counter = 0
        TimerLabel.text = "00 : 00 : 00"
        
        setupAnimation()
        animationView.pause()
        PauseButton.setTitle("Pause", for: UIControl.State.normal)
    }
    
    
    
    @objc func Action() {
        timerDisplayed += 1
        setupAnimation()
        Label.text = String(timerDisplayed)
    }
    
    
    @objc func timerCounter() {
        counter += 1
        let time = convertToHourMinSecond(seconds: counter)
        TimerLabel.text = getStringOfTime(hours: time.0, minutes: time.1, seconds: time.2)
    }
    
    
    func convertToHourMinSecond(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    
    func getStringOfTime(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        
        return timeString
    }
    
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet var PauseButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Animation cont
        setupAnimation()
        animationView.pause()
    }
    
    private func setupAnimation() {
        animationView.animation = Animation.named("falling-drop-of-water")
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
}
