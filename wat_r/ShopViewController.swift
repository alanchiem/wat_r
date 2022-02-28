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
        
        // Achievements
        if (TotalDrops > 2000) {
        print("wow")
        }

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
    
    @IBAction func ExpandUpgrade(_ sender: Any) {
        TotalDrops -= 100
        let DropDefault = UserDefaults.standard
        DropDefault.setValue(TotalDrops, forKey: "TotalDrops")
        DropDefault.synchronize()
        TotalDropsLabel.text = String(TotalDrops)
    }
    
}
