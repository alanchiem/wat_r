//
//  ViewController.swift
//  Class for the Stopwatch Mode of the app.
//  wat_r
//
//  Created by Alan Chiem on 1/12/21.
//

import UIKit
import Foundation
import Lottie

class ViewController: UIViewController {
    // Labels
    @IBOutlet weak var Label: UILabel! // displays number of droplets
    @IBOutlet weak var TimerLabel: UILabel! // displays time
    
    // Buttons
    @IBOutlet var PauseButton: UIButton!
    @IBOutlet var StartButton: UIButton!
    
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
            // increment water droplets by 2
            OurTimer = Timer.scheduledTimer(timeInterval: 2,
                                            target: self,
                                            selector: #selector(Action),
                                            userInfo: nil,
                                            repeats: true)
            
            // increment stopwatch by 1
            stopWatch = Timer.scheduledTimer(timeInterval: 1,
                                             target: self,
                                             selector: #selector(timerCounter),
                                             userInfo: nil,
                                             repeats: true)
            
            // timer is activated, timer is NOT paused
            timerActivated = true
            paused = false
            StartButton.setTitle("Reset", for: UIControl.State.normal)
            StartButton.setTitleColor(UIColor.red, for: UIControl.State.normal)
        }
        
        // when timer is already activated, just reset 
        else if (timerActivated == true)
        {
            OurTimer.invalidate()
            paused = true
            timerActivated = false
            timerDisplayed = 0
            Label.text = "0"
            
            stopWatch.invalidate()
            counter = 0
            TimerLabel.text = "00 : 00 : 00"
            
            setupAnimation()
            animationView.pause()
            PauseButton.setTitle("Pause", for: UIControl.State.normal)
            PauseButton.setTitleColor(UIColor.cyan, for: UIControl.State.normal)
            StartButton.setTitle("Start", for: UIControl.State.normal)
            StartButton.setTitleColor(UIColor.green, for: UIControl.State.normal)
        }
    }
    
    
    // Pause button, stops the timer
    @IBAction func PauseBTN(_ sender: Any) {
        // if stopwatch is in play
        if (paused == false) {
            OurTimer.invalidate()
            stopWatch.invalidate()
            animationView.pause()
            paused = true
            timerActivated = true
            PauseButton.setTitle("Play", for: UIControl.State.normal)
            PauseButton.setTitleColor(UIColor.green, for: UIControl.State.normal)
        }
        
        // if the stopwatch is currently paused and timer has been activated
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
            PauseButton.setTitleColor(UIColor.cyan, for: UIControl.State.normal)
        }
    }
    
    // increments the water droplet count displayed
    @objc func Action() {
        timerDisplayed += 1
        setupAnimation()
        Label.text = String(timerDisplayed)
    }
    
    // increments the stopwatch displayed
    @objc func timerCounter() {
        counter += 1
        let time = convertToHourMinSecond(seconds: counter)
        TimerLabel.text = getStringOfTime(hours: time.0, minutes: time.1, seconds: time.2)
    }
    
    // converts numbers of seconds to "hour : min : second" format
    func convertToHourMinSecond(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    // returns the string of the timer
    func getStringOfTime(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        
        return timeString
    }
    
    // when the app launches
    override func viewDidLoad() {
        super.viewDidLoad()
        // Animation cont
        setupAnimation()
        animationView.pause()
        StartButton.setTitleColor(UIColor.green, for: UIControl.State.normal)
        PauseButton.setTitleColor(UIColor.cyan, for: UIControl.State.normal)
    }
    
    // function for animation
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
