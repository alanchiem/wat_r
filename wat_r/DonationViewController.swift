//
//  DonationViewController.swift
//  wat_r
//
//  Created by Alan Chiem on 3/8/22.
//

import UIKit

class DonationViewController: UIViewController {

    @IBOutlet weak var noteTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTextView.text = "A note from the developer: \n\nThank you for using this app. I hope it has served you well. If there is anything I can do to make your experience better, please let me know by leaving a review. \n\nIf you would like to support me financially, please consider donating to one of the following charities below first. "
    }
    


}
