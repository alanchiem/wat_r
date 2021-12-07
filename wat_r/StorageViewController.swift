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
    
    @IBOutlet weak var fullLabel: UILabel!
    @IBOutlet weak var threeFourthsLabel: UILabel!
    @IBOutlet weak var halfLabel: UILabel!
    @IBOutlet weak var quarterLabel: UILabel!
    
    // Reset Button: resets total drops accumulated
    @IBOutlet var Reset: UIButton!
    
    @IBOutlet weak var waterRectangle: UIImageView!
    
    // Score labels
    var TotalDrops = 0
    
    // container
    var measurementInt = 2000

    
    override func viewWillAppear(_ animated: Bool) {

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
            TotalDropsLabel.text = String(TotalDrops)
        }
        
        // set up exchange data for timer
        NotificationCenter.default.addObserver(self, selector: #selector(notificationForTimer(_:)), name: Notification.Name("timer"), object: nil)
        

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
    
    }
    
    // add notification thing for the timer
    @objc func notificationForTimer(_ notification: Notification) {
        let text = notification.object as! String?
        TotalDropsLabel.text = String(Int(text!)! + TotalDrops)
        TotalDrops = Int(TotalDropsLabel.text!)!
       
        let DropDefault = UserDefaults.standard
        DropDefault.setValue(TotalDrops, forKey: "TotalDrops")
        DropDefault.synchronize()
        TotalDropsLabel.text = String(TotalDrops)
        

    
    }
    
    // override "didReceiveMemoryWarning" function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Reset Button
    @IBAction func ResetAction(sender: AnyObject) {
        TotalDrops = 1999
        let DropDefault = UserDefaults.standard
        DropDefault.setValue(TotalDrops, forKey: "TotalDrops")
        DropDefault.synchronize()
        TotalDropsLabel.text = String(TotalDrops)
    }
}
