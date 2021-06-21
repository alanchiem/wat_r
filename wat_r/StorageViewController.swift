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
    // Labels
    @IBOutlet var TotalDropsLabel: UILabel!
    
    @IBOutlet weak var MeasurementLabel: UILabel!

    @IBOutlet weak var TESTLABEL: UILabel!
    
    // Reset Button: resets total drops accumulated
    @IBOutlet var Reset: UIButton!
    
    // Score labels
    var TotalDrops = 0
    
    // container
    var measurementInt = 296
    
    
    // Changes the MeasurementLabel based on # of TotalDrops
    func updateMeasurement () {
        if (TotalDrops < 296) {
            MeasurementLabel.text = "1 Tablespoon (296)"
            measurementInt = 296
        }
        
        if (TotalDrops >= 296) {
            MeasurementLabel.text = "1 Ounce (567)"
            measurementInt = 567
        }
        
        else if (TotalDrops >= 567 && TotalDrops < 4732) {
            MeasurementLabel.text = "1 Ounce (567)"
            measurementInt = 567
        }
                
        else if (TotalDrops >= 4732 && TotalDrops < 6804) {
            MeasurementLabel.text = "1 Cup (4732)"
            measurementInt = 4732
        }
                
        else if (TotalDrops >= 6804 && TotalDrops < 10206) {
            MeasurementLabel.text = "12 Ounces (6804)"
            measurementInt = 6804
        }
        
        else if (TotalDrops >= 10206 && TotalDrops < 11340) {
            MeasurementLabel.text = "18 ounces"
        }
        
        else if (TotalDrops >= 11340 && TotalDrops < 11970) {
            MeasurementLabel.text = "20 ounces"
        }
        
        else if (TotalDrops >= 11970 && TotalDrops < 13608) {
            MeasurementLabel.text = "21 ounces"
        }
        
        // 9-15
        else if (TotalDrops >= 13608 && TotalDrops < 18144) {
            MeasurementLabel.text = "24 Ounces (13608)"
        }
                
        else if (TotalDrops >= 18144 && TotalDrops < 20000) {
            MeasurementLabel.text = "32 Ounces (18144)"
        }
                
        else if (TotalDrops >= 20000 && TotalDrops < 22680) {
            MeasurementLabel.text = "1 Liter (20000)"
        }
                
        else if (TotalDrops >= 22680 && TotalDrops < 36288) {
            MeasurementLabel.text = "40 Ounces (22680)"
        }
                
        else if (TotalDrops >= 36288 && TotalDrops < 75708) {
            MeasurementLabel.text = "64 Ounces (36288)"
        }
                
        else if (TotalDrops >= 75708 && TotalDrops < 30093930) {
            MeasurementLabel.text = "1 Gallon (75708)"
        }
                
        else if (TotalDrops >= 30093930 && TotalDrops < 14372709552) {
            MeasurementLabel.text = "Average Hot Tub - 397.5 Gallons (30093930)"
        }
        
        else if (TotalDrops >= 14372709552 && TotalDrops < 49967280000) {
            MeasurementLabel.text = "Avg Swimming Pool SCY"
        }
        
        else if (TotalDrops >= 49967280000 && TotalDrops < 393681600000) {
            MeasurementLabel.text = "Avg Swimming Pool LCM"
        }
        
        else if (TotalDrops >= 393681600000 && TotalDrops < 15200000000000) {
            MeasurementLabel.text = "Mississippi River"
        }
    }
    
    func updateAnimation() {
        let waterRatio = Float(TotalDrops) / Float(measurementInt)
        let yValueUpsideDown = waterRatio * 660
        //FOR TROUBLESHOOTING
        TESTLABEL.text = "Water Ratio: " + String(waterRatio)
        let yValue = 760 - yValueUpsideDown
        animationView!.center = CGPoint(x: 208, y: Int(yValue))
    }
    
    // 1. Create the AnimationView
    private var animationView: AnimationView?
    
    
    // When code launches
    // The high score label should be the last saved High Score from previous use
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up exchange data for stopwatch
        NotificationCenter.default.addObserver(self, selector: #selector(notificationForStopwatch(_:)), name: Notification.Name("text"), object: nil)
        let DropDefault = UserDefaults.standard
        if (DropDefault.value(forKey: "TotalDrops") != nil) {
            TotalDrops = DropDefault.value(forKey: "TotalDrops") as! NSInteger
            TotalDropsLabel.text = String(format: "Total Drops : %i", TotalDrops)
        }
        
        // set up exchange data for timer
        NotificationCenter.default.addObserver(self, selector: #selector(notificationForTimer(_:)), name: Notification.Name("timer"), object: nil)
        
        updateMeasurement()

        // 2. Start AnimationView with animation name (without extension)
        animationView = .init(name: "newWave")
        animationView!.frame = view.bounds
        animationView!.center = CGPoint(x: 208, y: 660)
        
        updateAnimation()
        
        // 3. Set animation content mode
        animationView!.contentMode = .scaleAspectFit
        animationView!.transform = CGAffineTransform(rotationAngle: .pi)
    
        
        // 4. Set animation loop mode
        animationView!.loopMode = .loop
        
        // 5. Adjust animation speed
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        
        // 6. Play animation
        animationView!.play()
        animationView!.backgroundBehavior = .pauseAndRestore
        
        view.bringSubviewToFront(Reset)
    }
    
    
    // add notification thing for the timer
    @objc func notificationForTimer(_ notification: Notification) {
        let text = notification.object as! String?
        TotalDropsLabel.text = String(Int(text!)! + TotalDrops)
        TotalDrops = Int(TotalDropsLabel.text!)!
       
        let DropDefault = UserDefaults.standard
        DropDefault.setValue(TotalDrops, forKey: "TotalDrops")
        DropDefault.synchronize()
        TotalDropsLabel.text = String(format: "Total Drops : %i", TotalDrops)
        
        updateMeasurement()
        
        updateAnimation()

        
        view.bringSubviewToFront(Reset)
    }
    
        
    
    // notification thing for the stopwatch
    @objc func notificationForStopwatch(_ notification: Notification) {
        let text = notification.object as! String?
        TotalDropsLabel.text = String(Int(text!)! + TotalDrops)
        TotalDrops = Int(TotalDropsLabel.text!)!
        

    
        let DropDefault = UserDefaults.standard
        DropDefault.setValue(TotalDrops, forKey: "TotalDrops")
        DropDefault.synchronize()
        TotalDropsLabel.text = String(format: "Total Drops : %i", TotalDrops)
        
        updateMeasurement()
        
        updateAnimation()
        
        view.bringSubviewToFront(Reset)
    }
    
    // override "didReceiveMemoryWarning" function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Reset Button
    @IBAction func ResetAction(sender: AnyObject) {
        TotalDrops = 0
        let DropDefault = UserDefaults.standard
        DropDefault.setValue(TotalDrops, forKey: "TotalDrops")
        DropDefault.synchronize()
        TotalDropsLabel.text = String(format: "Total Drops : %i", TotalDrops)
        
        updateMeasurement()
        updateAnimation()
    }
}
