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
    
    // Badge Declaration
    let button = UIButton(frame: CGRect(x: 100, y: 200, width: 75, height: 75))
    @objc func buttonAction(sender: UIButton!) {
      print("Button tapped")
    }
    
    
    // Happens everytime view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dropToTime()
        
        // Badge Appearance
        if (TotalDrops > 0) {
            button.backgroundColor = .blue
            button.setTitle("Test Button", for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            view.addSubview(button)
            }
        if (TotalDrops == 0) {
            button.removeFromSuperview()
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
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
        TotalDrops = 0
        let DropDefault = UserDefaults.standard
        DropDefault.setValue(TotalDrops, forKey: "TotalDrops")
        DropDefault.synchronize()
        TotalDropsLabel.text = String(TotalDrops)
    }
    
}
