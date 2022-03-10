//
//  StorageViewController.swift
//  wat_r
//
//  Created by Ricky Kuang on 6/5/21.
//

import UIKit
import Foundation
import Lottie

class StorageViewController: UIViewController {
    // Hides Time, Wifi, Battery
    override var prefersStatusBarHidden: Bool {
        return true
    }
    // Shows Drops, would be hidden but is used for debugging
    @IBOutlet var TotalDropsLabel: UILabel!

    // Shows Time, would be hidden but is used for debugging
    @IBOutlet weak var StatsLabel: UILabel!
    
    // Reset Button: resets total drops accumulated
    @IBOutlet var Reset: UIButton!
    
    
    
    func updateWaterPos() {
        let defaults = UserDefaults.standard
        let drops = defaults.integer(forKey: "drops")
        
        // 18,000 drops is 10 hours
        
        let waterRatio = Float(drops) / Float(18000)
        // opposite because newWave animation is upside down
        let oppositeRatio = 1 - waterRatio
        let bot = Int(self.view.frame.maxY) - 55
        let top = Int(self.view.frame.minY) - 87
        let yPos = Float(bot - top) * oppositeRatio
        // Int(yPos) - 87
        animationView!.center = CGPoint(x: Int(self.view.frame.maxX) / 2, y: Int(yPos) - 87)
        
        // prevents from covering up drops/time label
        self.view.sendSubviewToBack(animationView!)
        
        // water rectangle
        var waterRectangle: UIView!
        let rectBot = Int(self.view.frame.maxY) - 1
        let rectYPos = oppositeRatio * Float(rectBot) + 50.0
        waterRectangle = UIView(frame: CGRect(x: 0, y: Int(rectYPos), width: Int(self.view.frame.maxX), height: Int(self.view.frame.maxY)))
        // pocari sweat color
        waterRectangle.backgroundColor = UIColor(named: "color")
        view.addSubview(waterRectangle)
        self.view.sendSubviewToBack(waterRectangle)
    }
    
    // Drops | Time Button (Functionality), would be visible
    // Allows for the user to switch from displaying drop to displaying time by just tapping
    let conversions = ["drops", "time", "money"]
    
    
    
    let button = UIButton(frame: CGRect(x: 100, y: 200, width: 250, height: 40))

    
    // when button is tapped
    @objc func buttonAction(sender: UIButton!) {
        let defaults = UserDefaults.standard
        let monBool = defaults.bool(forKey: "moneyBool")
        
        let index = defaults.integer(forKey: "conversionIndex")
        
        if (index == 0) {
            defaults.set(index + 1, forKey: "conversionIndex")
            displayCorrectConversion()
        }
        else if (index == 1) {
            if (monBool) {
                defaults.set(index + 1, forKey: "conversionIndex")
                displayCorrectConversion()
            }
            else {
                defaults.set(index - 1, forKey: "conversionIndex")
                displayCorrectConversion()
            }
        }
        else if (index == 2) {
            defaults.set(0, forKey: "conversionIndex")
            displayCorrectConversion()
        }
    }
    
    func displayCorrectConversion() {
        let defaults = UserDefaults.standard
        let index = defaults.integer(forKey: "conversionIndex")
        let drops = defaults.integer(forKey: "drops")
        
        if (index == 0) {
            button.setTitle(String(drops), for: .normal)
        }
        if (index == 1) {
            button.setTitle(StatsLabel.text, for: .normal)
        }
        if (index == 2) {
            let money = Float(drops) / 100
            button.setTitle("$" + String(money), for: .normal)
        }
    }
    
    // 1. Create the AnimationView
    private var animationView: AnimationView?
    
    func animationFunction() {
        // 2. Start AnimationView with animation name (without extension)
        animationView = .init(name: "newWave")
        animationView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.maxX + 2, height: self.view.frame.maxX + 2)
        
        
        updateWaterPos()
   
        
        // 3. Set animation content mode
        animationView!.contentMode = .scaleAspectFit
        animationView!.transform = CGAffineTransform(rotationAngle: .pi)
        
        // 4. Set animation loop mode
        animationView!.loopMode = .loop
        
        // 5. Adjust animation speed
        animationView!.animationSpeed = 0.7
        view.addSubview(animationView!)
        
        // 6. Create ColorValueProvider using Lottie's Color class
//        var waveColor = Color(r: (66/255), g: (130/255), b: (174/255), a: 1)
        
//        if UITraitCollection.current.userInterfaceStyle == .dark {
//                waveColor = Color(r: (27/255), g: (83/255), b: (132/255), a: 1)
//            }
//            else {
//
//            }
        let waveColor = Color(r: (27/255), g: (83/255), b: (132/255), a: 1)
        let waveColorValueProvider = ColorValueProvider(waveColor)

        // Set color value provider to animation view
        let keyPath = AnimationKeypath(keypath: "**.Color")
        animationView!.setValueProvider(waveColorValueProvider, keypath: keyPath)
        
        // 7. Play animation
        animationView!.play()
        animationView!.backgroundBehavior = .pauseAndRestore
    }

    
    // Happens everytime view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dropToTime()
        updateWaterPos()
        
        
        // Drops | Time Button (Atrributes), would be visible
        let defaults = UserDefaults.standard
        let drops = defaults.integer(forKey: "drops")
        if (drops > 0) {
            // Button Color
            button.backgroundColor = .clear
            if UITraitCollection.current.userInterfaceStyle == .dark {
                button.setTitleColor(.white, for: .normal)
                button.setTitleColor(.lightGray, for: .highlighted)
            }
            else {
                button.setTitleColor(.lightGray, for: .normal)
                button.setTitleColor(.white, for: .highlighted)
            }
        }
        
        // if hidden is on
        let storageBool = defaults.bool(forKey: "hideStorageBool")
        if (storageBool) {
            button.setTitleColor(.clear, for: .normal)
            button.setTitleColor(.clear, for: .highlighted)
        }
        
        // Text
        displayCorrectConversion()
        button.titleLabel!.font = UIFont(name: "AppleSDGothicNeo-Thin" , size: 25)
        
        // Action
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        // Positioning
        button.center = self.view.center
        
        view.addSubview(button)
        
    }
    
    // Transgerred Data using Segue
    var transferredDrops = 0
    
    // When code launches Only happens once
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let drops = defaults.integer(forKey: "drops")
        defaults.set(drops + transferredDrops, forKey: "drops")
        let newDrops = defaults.integer(forKey: "drops")
        
        TotalDropsLabel.text = String(newDrops)
        
        animationFunction()
        updateWaterPos()
        }

    
    // convert Total Drops to time
    func dropToTime() {
        let defaults = UserDefaults.standard
        let drops = defaults.integer(forKey: "drops")
        var n = drops * 2
        let days = n / (24 * 3600)
     
        n = n % (24 * 3600)
        let hours = n / 3600
     
        n %= 3600
        let minutes = n / 60
     
        n %= 60
        let seconds = n
        StatsLabel.text = String(days) + "d " + String(hours) + "h " + String(minutes) + "m " + String(seconds) + "s"
    }
    
    // override "didReceiveMemoryWarning" function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Reset Button
    @IBAction func ResetAction(sender: AnyObject) {

    }
    
}
