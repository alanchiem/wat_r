//
//  SettingsViewController.swift
//  wat_r
//
//  Created by Alan Chiem on 3/8/22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var warningBox: UIView!
    
    @IBOutlet weak var batterySavingSwitch: UISwitch!
    @IBAction func batteryAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(batterySavingSwitch.isOn, forKey: "batteryBool")
    }
    
    
    @IBOutlet weak var moneySwitch: UISwitch!
    
    @IBAction func moneyAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(moneySwitch.isOn, forKey: "moneyBool")
    }
    
    @IBOutlet weak var hideStorageLabelSwitch: UISwitch!
    
    @IBAction func hideStorageAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(hideStorageLabelSwitch.isOn, forKey: "hideStorageBool")
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        // sets switch to be on/off
        let defaults = UserDefaults.standard
        
        let battBool = defaults.bool(forKey: "batteryBool")
        self.batterySavingSwitch.isOn = battBool
        
        let monBool = defaults.bool(forKey: "moneyBool")
        self.moneySwitch.isOn = monBool
        
        let storageBool = defaults.bool(forKey: "hideStorageBool")
        self.hideStorageLabelSwitch.isOn = storageBool
       
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // red box
        warningBox.layer.borderWidth = 1
        warningBox.layer.borderColor = UIColor.red.cgColor
        

    }


}
