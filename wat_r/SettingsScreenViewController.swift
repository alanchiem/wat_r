//
//  SettingsScreenViewController.swift
//  wat_r
//
//  Created by Alan Chiem on 1/13/21.
//

import UIKit

class SettingsScreenViewController: UIViewController {

    // this currently doesn't do anything
    @IBAction func Close() {
        dismiss(animated: true, completion: nil)
    }
    
    // labels
    // currently outdated; "DarkModeLabel" attached to "Daily Bonus"
    @IBOutlet weak var DarkModeLabel: UILabel!
    @IBOutlet weak var outletSwitch: UISwitch!
    
    // when app loads
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // makes app turn to dark mode
    @IBAction func DarkModeAction(_ sender: Any) {
        if outletSwitch.isOn == true {
           // view.backgroundColor = UIColor.black
        }
        else {
           // view.backgroundColor = UIColor.white
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
