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
    
    @IBOutlet weak var halfLabel: UILabel!
    
    // Reset Button: resets total drops accumulated
    @IBOutlet var Reset: UIButton!
    
    @IBOutlet weak var waterRectangle: UIImageView!
    
    // Score labels
    var TotalDrops = 0
    
    // container
    var measurementInt = 296

    
    
    // Changes the MeasurementLabel based on # of TotalDrops
    func updateMeasurement () {
        if (TotalDrops < 296) {
            MeasurementLabel.text = "1TBSP"
            measurementInt = 296
        }
                
        else if (TotalDrops >= 296 && TotalDrops < 567) {
            MeasurementLabel.text = "OUNCE"
            measurementInt = 567
        }
                
                
        else if (TotalDrops >= 567 && TotalDrops < 4732) {
            MeasurementLabel.text = "1 CUP"
            measurementInt = 4732
        }
                        
        else if (TotalDrops >= 4732 && TotalDrops < 6804) {
            MeasurementLabel.text = "12 OUNCES"
            measurementInt = 6804
        }
                        
        else if (TotalDrops >= 6804 && TotalDrops < 10206) {
            MeasurementLabel.text = "18 OUNCES"
            measurementInt = 10206
        }
                
        else if (TotalDrops >= 10206 && TotalDrops < 11340) {
            MeasurementLabel.text = "20 OUNCES"
            measurementInt = 11340
        }
                
        else if (TotalDrops >= 11340 && TotalDrops < 11970) {
            MeasurementLabel.text = "21 OUNCES"
            measurementInt = 11970
        }
    }
    
    func updateAnimation() {
        let waterRatio = Float(TotalDrops) / Float(measurementInt)
        let yValueUpsideDown = waterRatio * 660
        
        //FOR TROUBLESHOOTING
        print("Water Ratio: " + String(waterRatio))
        
        let yValue = 760 - yValueUpsideDown
        print("y Value: " + String(yValue))
        print("y Value int: " + String(Int(yValue) + 520))
        animationView!.center = CGPoint(x: 208, y: Int(yValue))
        waterRectangle.center = CGPoint(x: 208, y: Int(yValue) + 500)
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
            TotalDropsLabel.text = String(format: "Total Drops: %i", TotalDrops)
        }
        
        // set up exchange data for timer
        NotificationCenter.default.addObserver(self, selector: #selector(notificationForTimer(_:)), name: Notification.Name("timer"), object: nil)
        
        

        // 2. Start AnimationView with animation name (without extension)
        animationView = .init(name: "newWave")
        animationView!.frame = CGRect(x: 0, y: 0, width: 420, height: 420)
        animationView!.center = CGPoint(x: 208, y: 660)
        
        
        
        // 3. Set animation content mode
        animationView!.contentMode = .scaleAspectFit
        animationView!.transform = CGAffineTransform(rotationAngle: .pi)
        
        updateMeasurement()
        updateAnimation()
        
        // 4. Set animation loop mode
        animationView!.loopMode = .loop
        
        // 5. Adjust animation speed
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        
        // 6. Play animation
        animationView!.play()
        animationView!.backgroundBehavior = .pauseAndRestore
        
        updateMeasurement()
        updateAnimation()
        
        view.bringSubviewToFront(Reset)
        view.bringSubviewToFront(halfLabel)
        view.bringSubviewToFront(MeasurementLabel)
    }
    
    // add notification thing for the timer
    @objc func notificationForTimer(_ notification: Notification) {
        let text = notification.object as! String?
        TotalDropsLabel.text = String(Int(text!)! + TotalDrops)
        TotalDrops = Int(TotalDropsLabel.text!)!
       
        let DropDefault = UserDefaults.standard
        DropDefault.setValue(TotalDrops, forKey: "TotalDrops")
        DropDefault.synchronize()
        TotalDropsLabel.text = String(format: "Total Drops: %i", TotalDrops)
        
        updateMeasurement()
        
        updateAnimation()

        
        view.bringSubviewToFront(Reset)
        view.bringSubviewToFront(halfLabel)
        view.bringSubviewToFront(MeasurementLabel)
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
        view.bringSubviewToFront(halfLabel)
        view.bringSubviewToFront(MeasurementLabel)
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
