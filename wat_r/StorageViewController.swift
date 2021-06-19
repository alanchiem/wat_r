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

    
    // Reset Button: resets total drops accumulated
    @IBOutlet var Reset: UIButton!
    
    // Score labels
    var TotalDrops = 0
    
    // Changes the MeasurementLabel based on # of TotalDrops
    func updateMeasurement () {
        MeasurementLabel.text = "1 Tablespoon (296)"
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
        animationView = .init(name: "storage_water")
        animationView!.frame = view.bounds
        
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
    }
}
