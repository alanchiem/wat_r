//
//  DonationViewController.swift
//  wat_r
//
//  Created by Alan Chiem on 3/8/22.
//

import UIKit

class DonationViewController: UIViewController {
    // Hides Time, Wifi, Battery
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBOutlet weak var noteTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTextView.text = "A note from the developer: \n\nThank you for using this app. If there is anything I can do to make your experience better, please let me know by leaving a review. \n\nIf you would like to support me monetarily, please consider donating to one of the following charities below instead.\n\ncharitywater.org \n\nteamseas.org \n\nwater.org"
    }
    


}
