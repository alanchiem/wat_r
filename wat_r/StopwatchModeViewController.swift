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

class StopwatchModeViewController: UIViewController {
    // Hides Time, Wifi, Battery
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Labels
    @IBOutlet weak var DropsLabel: UILabel! // displays number of droplets
    @IBOutlet weak var TimerLabel: UILabel! // displays time
    
    // For the water droplets counter
    var droplets = Timer()
    var dropsDisplayed = 0
    var paused = true
    
    // For the stopwatch timer
    var stopWatch = Timer()
    var counter = 0
    
    // Animation
    let animationView = AnimationView()
    
    // when the app launches
    override func viewDidLoad() {
        super.viewDidLoad()
        // Animation cont
        setupAnimation()
        animationView.pause()
        
        
        let oneTap = UITapGestureRecognizer(target: self, action: #selector(singleTap))
            oneTap.numberOfTapsRequired = 1
            view.addGestureRecognizer(oneTap)
        
        let twoTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
            twoTap.numberOfTapsRequired = 2
            view.addGestureRecognizer(twoTap)
    }
    
    // Start / Pause
    @objc func singleTap() {
        if (paused == true) {

            
        // increment water droplets by 2
        droplets = Timer.scheduledTimer(timeInterval: 2,
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
        
        // play animation
        animationView.play()
            
        // Timer is NOT paused
        paused = false
        }
        
        // if stopwatch is in play
        else if (paused == false) {
            droplets.invalidate()
            stopWatch.invalidate()
            animationView.pause()
            paused = true
        }
    }
    

    // Using Segue to pass data (name of segue: "dropsSegue")
    var earnedDrops = 0
    
    // Reset
    @objc func doubleTapped() {
        //NotificationCenter.default.post(name: Notification.Name("text"), object: DropsLabel.text)
        self.earnedDrops = dropsDisplayed
        performSegue(withIdentifier: "dropsSegue", sender: self)
        
        droplets.invalidate()
        dropsDisplayed = 0
        DropsLabel.text = "0"
        
        stopWatch.invalidate()
        counter = 0
        TimerLabel.text = "00 : 00 : 00"
        
        setupAnimation()
        animationView.pause()
        paused = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ShopViewController
        vc.transferredDrops = self.earnedDrops
    }
    
    // increments the water droplet count displayed
    @objc func Action() {
        dropsDisplayed += 1
        setupAnimation()
        DropsLabel.text = String(dropsDisplayed)
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
    
    // function for animation
    private func setupAnimation() {
        animationView.animation = Animation.named("newWaterdrop")
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        
        //Randomize droplet location
        let xValue = Int.random(in: Int(self.view.frame.minX)..<Int(self.view.frame.maxX))
        let yValue = Int.random(in: Int(self.view.frame.minY)..<Int(self.view.frame.maxY))
        animationView.center = CGPoint(x: xValue, y: yValue)
        
        //Changing Color of the droplet
        var dropColor = Color(r: (66/255), g: (130/255), b: (174/255), a: 1)
        
        if UITraitCollection.current.userInterfaceStyle == .dark {
                dropColor = Color(r: (27/255), g: (83/255), b: (132/255), a: 1)
            }
            else {
            }
        
        let waveColorValueProvider = ColorValueProvider(dropColor)

        // Set color value provider to animation view
        let keyPath = AnimationKeypath(keypath: "**.Color")
        animationView.setValueProvider(waveColorValueProvider, keypath: keyPath)
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
}
