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
    @IBOutlet weak var DropsLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    
    // Picker
    @IBOutlet var picker: UIPickerView!
    @IBOutlet weak var hourText: UILabel!
    @IBOutlet weak var minText: UILabel!
    @IBOutlet weak var secText: UILabel!
    
    // Buttons
    @IBOutlet var PauseButton: UIButton!
    @IBOutlet var StartButton: UIButton!
    
    // Hour, minutes, seconds
    var hour = 0
    var min = 0
    var sec = 0
    
    // For the water droplets counter
    var OurTimer = Timer()
    var timerDisplayed = 0
    
    
    // For the stopwatch timer
    var countDownTimer = Timer()
    var counter = 0 // have to change the code so that this is a user input
    var secondsLost = 0
    
    
    // Tracks whether timer started and whether timer has been paused
    var timerActivated = false
    var paused = true
    
    // Animation
    let animationView = AnimationView()
    
    
    // Start button, starts the timer
    @IBAction func StartBTN(_ sender: Any) {
        // Case for when timer has not been started
        // If timer has been started, then button doesn't work
        if (timerActivated == false && counter > 0) {
            picker.isHidden = true
            hourText.isHidden = true
            minText.isHidden = true
            secText.isHidden = true
            TimerLabel.isHidden = false
            
            // lines 44 and 45 are for displaying the inputted time when "start" is clicked
            let time = convertToHourMinSecond(seconds: counter)
            secondsLost = 0
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
            StartButton.setTitleColor(UIColor.red, for: UIControl.State.normal)
            StartButton.setTitle("Reset", for: UIControl.State.normal)
        }
        
        else if (timerActivated == true) {
            OurTimer.invalidate()

            
            NotificationCenter.default.post(name: Notification.Name("timer"), object: DropsLabel.text)
            
            timerDisplayed = 0
            DropsLabel.text = "0"
            counter += secondsLost
            secondsLost = 0
            countDownTimer.invalidate()
            TimerLabel.text = "-- : -- : --"
            TimerLabel.isHidden = true
            picker.isHidden = false
            hourText.isHidden = false
            minText.isHidden = false
            secText.isHidden = false
            
            setupAnimation()
            animationView.pause()
            
            timerActivated = false
            paused = true
            PauseButton.setTitle("Pause", for: UIControl.State.normal)
            PauseButton.setTitleColor(UIColor.cyan, for: UIControl.State.normal)
            StartButton.setTitle("Start", for: UIControl.State.normal)
            StartButton.setTitleColor(UIColor.green, for: UIControl.State.normal)
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
            PauseButton.setTitle("Play", for: UIControl.State.normal)
            PauseButton.setTitleColor(UIColor.green, for: UIControl.State.normal)
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
            PauseButton.setTitle("Pause", for: UIControl.State.normal)
            PauseButton.setTitleColor(UIColor.cyan, for: UIControl.State.normal)
        }
    }
    
    
    // Action to display the amount of droplets as well as the animation
    @objc func Action() {
        timerDisplayed += 1
        setupAnimation()
        DropsLabel.text = String(timerDisplayed)
    }
    
    
    // Action function to display the time
    @objc func timerCounter() {
        counter -= 1
        secondsLost += 1
        
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
        picker.dataSource = self
        picker.delegate = self
        TimerLabel.isHidden = true
        picker.isHidden = false
        hourText.isHidden = false
        minText.isHidden = false
        secText.isHidden = false
        
        // Set color for the buttons
        StartButton.setTitleColor(UIColor.green, for: UIControl.State.normal)
        PauseButton.setTitleColor(UIColor.cyan, for: UIControl.State.normal)
        
        // Hours, minutes, seconds for the picker
        pickerData = [["0", "1", "2", "3", "4"],
                      
                      ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                      "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                      "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
                      "31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
                      "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
                      "51", "52", "53", "54", "55", "56", "57", "58", "59"],
                      
                      ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                      "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                      "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
                      "31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
                      "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
                      "51", "52", "53", "54", "55", "56", "57", "58", "59"]]
    }
    
    // for drops animation
    private func setupAnimation() {
        animationView.animation = Animation.named("falling-drop-of-water")
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
    
    var pickerData: [[String]] = [[String]]()
    
    func view(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return
    }
}

extension TimerModeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // ISSUE: has to be moved in order to reset the timer
        if (component == 0) {
            hour = (pickerData[component][row] as NSString).integerValue
        }
        
        if (component == 1) {
            min = (pickerData[component][row] as NSString).integerValue
        }
        
        if (component == 2) {
            sec = (pickerData[component][row] as NSString).integerValue
        }
        counter = (hour * 60 * 60) + (min * 60) + sec
    }
}
