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
    @IBOutlet var StopwatchDropsLabel: UILabel!
    @IBOutlet var TimerDropsLabel: UILabel!
    
    // Reset Button: resets total drops accumulated
    @IBOutlet var Reset: UIButton!
    
    // Score labels
    var TimerDrops = 0
    var StopwatchDrops = 0
    
    // When code launches
    // The high score label should be the last saved High Score from previous use
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up exchange data for stopwatch
        NotificationCenter.default.addObserver(self, selector: #selector(notificationForStopwatch(_:)), name: Notification.Name("text"), object: nil)
        let StopwatchDropDefault = UserDefaults.standard
        if (StopwatchDropDefault.value(forKey: "StopwatchDrops") != nil) {
            StopwatchDrops = StopwatchDropDefault.value(forKey: "StopwatchDrops") as! NSInteger
            StopwatchDropsLabel.text = String(format: "Total Drops (Stopwatch) : %i", StopwatchDrops)
        }
        
        // set up exchange data for timer
        NotificationCenter.default.addObserver(self, selector: #selector(notificationForTimer(_:)), name: Notification.Name("timer"), object: nil)
        let TimerDropDefault = UserDefaults.standard
        if (TimerDropDefault.value(forKey: "TimerDrops") != nil) {
            TimerDrops = TimerDropDefault.value(forKey: "TimerDrops") as! NSInteger
            TimerDropsLabel.text = String(format: "Total Drops (Timer) : %i", TimerDrops)
        }
    }
    
    // add notification thing for the timer
    @objc func notificationForTimer(_ notification: Notification) {
        let text = notification.object as! String?
        TimerDropsLabel.text = String(Int(text!)! + TimerDrops)
        TimerDrops = Int(TimerDropsLabel.text!)!
       
        let TimerDropDefault = UserDefaults.standard
        TimerDropDefault.setValue(TimerDrops, forKey: "TimerDrops")
        TimerDropDefault.synchronize()
        TimerDropsLabel.text = String(format: "Total Drops (Timer) : %i", TimerDrops)
    }
    
    // notification thing for the stopwatch
    @objc func notificationForStopwatch(_ notification: Notification) {
        let text = notification.object as! String?
        StopwatchDropsLabel.text = String(Int(text!)! + StopwatchDrops)
        StopwatchDrops = Int(StopwatchDropsLabel.text!)!
       
        let StopwatchDropDefault = UserDefaults.standard
        StopwatchDropDefault.setValue(StopwatchDrops, forKey: "StopwatchDrops")
        StopwatchDropDefault.synchronize()
        StopwatchDropsLabel.text = String(format: "Total Drops (Stopwatch) : %i", StopwatchDrops)
    }
    
    // override "didReceiveMemoryWarning" function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Reset Button
    @IBAction func ResetAction(sender: AnyObject) {
        TimerDrops = 0
        let TimerDropDefault = UserDefaults.standard
        TimerDropDefault.setValue(TimerDrops, forKey: "TimerDrops")
        TimerDropDefault.synchronize()
        TimerDropsLabel.text = String(format: "Total Drops (Timer) : %i", TimerDrops)
        
        StopwatchDrops = 0
        let StopwatchDropDefault = UserDefaults.standard
        StopwatchDropDefault.setValue(StopwatchDrops, forKey: "StopwatchDrops")
        StopwatchDropDefault.synchronize()
        StopwatchDropsLabel.text = String(format: "Total Drops (Stopwatch) : %i", StopwatchDrops)
    }
}
