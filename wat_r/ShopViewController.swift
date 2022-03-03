//
//  StorageViewController.swift
//  wat_r
//
//  Created by Ricky Kuang on 6/5/21.
//

import UIKit
import Foundation
import Lottie

class ShopViewController: UIViewController {
    // Shows Drops, would be hidden but is used for debugging
    @IBOutlet var TotalDropsLabel: UILabel!

    // Shows Time, would be hidden but is used for debugging
    @IBOutlet weak var StatsLabel: UILabel!
    
    // Reset Button: resets total drops accumulated
    @IBOutlet var Reset: UIButton!
    
    var TotalDrops = 0
    
    
    // 36 million drops == 10,000 hours

    
    // Drops | Time Button (Functionality), would be visible
    // Allows for the user to switch from displaying drop to displaying time by just tapping
    var showingDrops = true
    let button = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 40))
    // when button is tapped
    @objc func buttonAction(sender: UIButton!) {
        if (showingDrops) {
            showingDrops = false
            button.setTitle(StatsLabel.text, for: .normal)
        }
        else {
            showingDrops = true
            button.setTitle(String(TotalDrops), for: .normal)
        }
    }
    
    
    // 1. Create the AnimationView
    private var animationView: AnimationView?
    
    func animationFunction() {
        // 2. Start AnimationView with animation name (without extension)
        animationView = .init(name: "newWave")
        animationView!.frame = CGRect(x: 0, y: 0, width: 420, height: 420)
        
        // bottomish area
        animationView!.center = CGPoint(x: 208, y: 660)
        
        // middleish area
        //animationView!.center = CGPoint(x: 208, y: 260)
        
        // 3. Set animation content mode
        animationView!.contentMode = .scaleAspectFit
        animationView!.transform = CGAffineTransform(rotationAngle: .pi)
        
        // 4. Set animation loop mode
        animationView!.loopMode = .loop
        
        // 5. Adjust animation speed
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        
        // 6. Create ColorValueProvider using Lottie's Color class
        var waveColor = Color(r: (66/255), g: (130/255), b: (174/255), a: 1)
        
        if UITraitCollection.current.userInterfaceStyle == .dark {
                print("Dark mode")
                waveColor = Color(r: (27/255), g: (83/255), b: (132/255), a: 1)
            }
            else {
                print("Light mode")
                
            }
        
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
        
        // Drops | Time Button (Atrributes), would be visible
        if (TotalDrops > 0) {
            // Color
            button.backgroundColor = .clear
            if UITraitCollection.current.userInterfaceStyle == .dark {
                button.setTitleColor(.white, for: .normal)
            }
            else {
                button.setTitleColor(.black, for: .normal)
            }
            button.setTitleColor(.lightGray, for: .highlighted)
            
            }
            
            // Text
            button.setTitle(String(TotalDrops), for: .normal)
            button.titleLabel!.font = UIFont(name: "AppleSDGothicNeo-Thin" , size: 25)
            
            // Action
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            // Positioning
            button.center = self.view.center
            
            view.addSubview(button)
            
 
        
    }
    
    // When code launches Only happens once
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // set up exchange data for stopwatch
        NotificationCenter.default.addObserver(self, selector: #selector(notificationForStopwatch(_:)), name: Notification.Name("text"), object: nil)
        let DropDefault = UserDefaults.standard
        if (DropDefault.value(forKey: "TotalDrops") != nil) {
            TotalDrops = DropDefault.value(forKey: "TotalDrops") as! NSInteger
            TotalDropsLabel.text = String(TotalDrops)
        }
        dropToTime()
        
        animationFunction()
        
        }

    
    // notification thing for the stopwatch
    @objc func notificationForStopwatch(_ notification: Notification) {
        let text = notification.object as! String?
        TotalDropsLabel.text = String(Int(text!)! + TotalDrops)
        TotalDrops = Int(TotalDropsLabel.text!)!

        let DropDefault = UserDefaults.standard
        DropDefault.setValue(TotalDrops, forKey: "TotalDrops")
        DropDefault.synchronize()
        TotalDropsLabel.text = String(TotalDrops)
        
        dropToTime()
    }
    
    
    // convert Total Drops to time
    func dropToTime() {
        var n = TotalDrops * 2
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
        TotalDrops = 123456789
        let DropDefault = UserDefaults.standard
        DropDefault.setValue(TotalDrops, forKey: "TotalDrops")
        DropDefault.synchronize()
        TotalDropsLabel.text = String(TotalDrops)
        button.setTitle(String(TotalDrops), for: .normal)
    }
    
}