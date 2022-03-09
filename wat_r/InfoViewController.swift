//
//  SettingsViewController.swift
//  wat_r
//
//  Created by Alan Chiem on 3/7/22.
//

import UIKit

class InfoViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var numCharLabel: UILabel!
    @IBOutlet weak var futureTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.futureTextView.delegate = self
        let defaults = UserDefaults.standard
        let text = defaults.object(forKey: "futureText")
        
        futureTextView.text = text as? String
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.futureTextView.resignFirstResponder()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        numCharLabel.textColor = UIColor(named: "Text")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        numCharLabel.textColor = UIColor(named: "Background")
        let defaults = UserDefaults.standard
        if (futureTextView.text.count == 0) {
            let text = "To Future Me:"
            defaults.set(text, forKey: "futureText")

        } else {
            let text = futureTextView.text
            defaults.set(text, forKey: "futureText")

        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        numCharLabel.text = "\(futureTextView.text.count)"
        return futureTextView.text.count + (text.count - range.length) <= 200
    }
}
