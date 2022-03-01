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
    // Labels
    @IBOutlet var TotalDropsLabel: UILabel!
    
    // Reset Button: resets total drops accumulated
    @IBOutlet var Reset: UIButton!

    
    @IBOutlet weak var StatsLabel: UILabel!
    
    // Score labels
    var TotalDrops = 0
    

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
            TotalDropsLabel.text = String(TotalDrops)
        }
        
//        let n = TotalDrops
//        let days =  n / (24 * 3600)
//        let hours =  (n % (24 * 3600)) / 3600
//        let minutes =  (n % (24 * 3600 * 3600)) / 60
//        let seconds =  (n % (24 * 3600 * 3600 * 60)) / 60
//        StatsLabel.text = String(days) + " days" + String(hours) + " hours" + String(minutes) + " minutes" + String(seconds) + " seconds"
        var n = TotalDrops * 2
        let days = n / (24 * 3600)
     
        n = n % (24 * 3600)
        let hours = n / 3600
     
        n %= 3600
        let minutes = n / 60
     
        n %= 60
        let seconds = n
        StatsLabel.text = String(days) + " days" + String(hours) + " hours" + String(minutes) + " minutes" + String(seconds) + " seconds"
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
        
        
        var n = TotalDrops * 2
        let days = n / (24 * 3600)
     
        n = n % (24 * 3600)
        let hours = n / 3600
     
        n %= 3600
        let minutes = n / 60
     
        n %= 60
        let seconds = n
        StatsLabel.text = String(days) + " days" + String(hours) + " hours" + String(minutes) + " minutes" + String(seconds) + " seconds"

    }
    
    // override "didReceiveMemoryWarning" function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Reset Button
    @IBAction func ResetAction(sender: AnyObject) {
        TotalDrops = 369121517
        let DropDefault = UserDefaults.standard
        DropDefault.setValue(TotalDrops, forKey: "TotalDrops")
        DropDefault.synchronize()
        TotalDropsLabel.text = String(TotalDrops)
    }
    
    @IBAction func ExpandUpgrade(_ sender: Any) {
        TotalDrops -= 100
        let DropDefault = UserDefaults.standard
        DropDefault.setValue(TotalDrops, forKey: "TotalDrops")
        DropDefault.synchronize()
        TotalDropsLabel.text = String(TotalDrops)
    }
    
}
