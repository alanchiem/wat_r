//
//  SettingsViewController.swift
//  wat_r
//
//  Created by Alan Chiem on 3/8/22.
//

import UIKit
import SwiftUI
import AVKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    // Hides Time, Wifi, Battery
    override var prefersStatusBarHidden: Bool {
        return true
    }

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
    
    
    @IBOutlet weak var bellLabelSwitch: UISwitch!
    
    
    @IBAction func bellAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(bellLabelSwitch.isOn, forKey: "bellSoundBool")
        
        bellTimeInputLabel.isHidden = !bellLabelSwitch.isOn
        bellMinLabel.isHidden = !bellLabelSwitch.isOn
        soundTestOutlet.isHidden = !bellLabelSwitch.isOn
    }
    
    
    @IBOutlet weak var bellTimeInputLabel: UITextField!
    
    
    @IBOutlet weak var bellMinLabel: UILabel!
    
    
    @IBOutlet weak var soundTestOutlet: UIButton!
    @IBAction func soundTestAction(_ sender: Any) {
        // Allows for sound even when phone on silent
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        SoundManager.instance.playSound()
    }
    
    
    // Saves Input of BellMin with userdefaults as "bellMinInput", used in stopwatchviewcontroller
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bellTimeInputLabel.resignFirstResponder()
        let defaults = UserDefaults.standard
        let min = Int(bellTimeInputLabel.text!)
        defaults.set(min, forKey: "bellMinInput")
        bellTimeInputLabel.text = String(defaults.integer(forKey: "bellMinInput"))
        
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
       
        let bellBool = defaults.bool(forKey: "bellSoundBool")
        self.bellLabelSwitch.isOn = bellBool
   
        
        bellTimeInputLabel.keyboardType = .numberPad
        bellTimeInputLabel.text = String(defaults.integer(forKey: "bellMinInput"))

        
        if (!bellBool) {
            bellTimeInputLabel.isHidden = true
            bellMinLabel.isHidden = true
            soundTestOutlet.isHidden = true
        }
        else {
            bellTimeInputLabel.isHidden = false
            bellMinLabel.isHidden = false
            soundTestOutlet.isHidden = false
        }
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // red box
        warningBox.layer.borderWidth = 1
        warningBox.layer.borderColor = UIColor.red.cgColor
        
    }

}
