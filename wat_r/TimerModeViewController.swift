//
//  TimerModeViewController.swift
//  wat_r
//
//  Created by Ricky Kuang on 1/28/21.
//

import UIKit
import Foundation
import Lottie

class TimerModeViewController: UIViewController {
    
    // Labels
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    
    
    // For the water droplets counter
    var OurTimer = Timer()
    var timerDisplayed = 0
    
    
    // For the stopwatch timer
    var countDownTimer = Timer()
    var counter = 10 // have to change the code so that this is a user input
    
    
    // Tracks whether timer started and whether timer has been paused
    var timerActivated = false
    var paused = true
    
    
    // Animation
    let animationView = AnimationView()
    
    
    // Start button, starts the timer
    @IBAction func StartBTN(_ sender: Any) {
        // Case for when timer has not been started
        // If timer has been started, then button doesn't work
        if (timerActivated == false) {
            // lines 44 and 45 are for displaying the inputted time when "start" is clicked
            let time = convertToHourMinSecond(seconds: counter)
            TimerLabel.text = getStringOfTime(hours: time.0, minutes: time.1, seconds: time.2)
            
            OurTimer = Timer.scheduledTimer(timeInterval: 2,
                                            target: self,
                                            selector: #selector(Action),
                                            userInfo: nil,
                                            repeats: true)
            
            countDownTimer = Timer.scheduledTimer(timeInterval: 1,
                                             target: self,
                                             selector: #selector(timerCounter),
                                             userInfo: nil,
                                             repeats: true)
            
            timerActivated = true
            paused = false
        }
    }
    
    
    // Pause button, stops the timer
    @IBAction func PauseBTN(_ sender: Any) {
        // Case for when the timer isn't paused.
        // Stopwatch and "droplet" timer stop, as well as animation
        // Timer has to be already activated initially.
        if (paused == false && timerActivated == true) {
            OurTimer.invalidate()
            countDownTimer.invalidate()
            animationView.pause()
            paused = true
        }
        
        // Case for when the timer is paused
        // Stopwatch and "droplet" timer start again, as well as animation
        // Conditional also prevents pause button from working when time has already reached 0
        else if (paused == true && counter > 0 && timerActivated == true) {
            OurTimer = Timer.scheduledTimer(timeInterval: 2,
                                            target: self,
                                            selector: #selector(Action),
                                            userInfo: nil,
                                            repeats: true)
            
            countDownTimer = Timer.scheduledTimer(timeInterval: 1,
                                             target: self,
                                             selector: #selector(timerCounter),
                                             userInfo: nil,
                                             repeats: true)
            
            animationView.play()
            paused = false
        }
    }
    
    
    // Reset button, sets timers back to 0
    @IBAction func ResetBTN(_ sender: Any) {
        OurTimer.invalidate()
        timerDisplayed = 0
        Label.text = "0"
        
        countDownTimer.invalidate()
        counter = 10 // change this to user input
        TimerLabel.text = "-- : -- : --"
        
        setupAnimation()
        animationView.pause()
        
        timerActivated = false
        paused = true
    }
    
    
    // Action to display the amount of droplets as well as the animation
    @objc func Action() {
        timerDisplayed += 1
        setupAnimation()
        Label.text = String(timerDisplayed)
    }
    
    
    // Action function to display the time
    @objc func timerCounter() {
        counter -= 1
        let time = convertToHourMinSecond(seconds: counter)
        TimerLabel.text = getStringOfTime(hours: time.0, minutes: time.1, seconds: time.2)
        
        // If statement for when the timer is done. Stops the timers and animation.
        if (counter == 0) {
            OurTimer.invalidate()
            countDownTimer.invalidate()
            animationView.pause()
            timerActivated = false
            paused = true
        }
    }
    
    
    // Converts seconds into Hour : Minute : Second format
    func convertToHourMinSecond(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    
    // Returns the string version of the time converted into Hour : Minute : String format
    func getStringOfTime(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        
        return timeString
    }
    

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
