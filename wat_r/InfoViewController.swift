//
//  SettingsViewController.swift
//  wat_r
//
//  Created by Alan Chiem on 3/7/22.
//

import UIKit

extension Date {
  func offset(from date: Date) -> String {

    let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
    let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)

    let seconds = "\(difference.second ?? 0)s"
    let minutes = "\(difference.minute ?? 0)m" + " " + seconds
    let hours = "\(difference.hour ?? 0)h" + " " + minutes
    let days = "\(difference.day ?? 0)d" + " " + hours

    if let day = difference.day, day          > 0 { return days }
    if let hour = difference.hour, hour       > 0 { return hours }
    if let minute = difference.minute, minute > 0 { return minutes }
    if let second = difference.second, second > 0 { return seconds }
    return ""
  }
}

class InfoViewController: UIViewController, UITextViewDelegate {
    // Hides Time, Wifi, Battery
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var numCharLabel: UILabel!
    @IBOutlet weak var futureTextView: UITextView!

    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var totalDropsLabel: UILabel!
    
    @IBOutlet weak var containerSizeLabel: UILabel!
    
    @IBOutlet weak var ratioLabel: UILabel!
    
    @IBOutlet weak var todaysTime: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBAction func backdropButton(_ sender: Any) {
        
    }
    
    
    func dropsToTimeTodayLabel() {
        let defaults = UserDefaults.standard
        let drops = defaults.integer(forKey: "todaysDrops")
        var n = drops * 2
        
        n = n % (24 * 3600)
        let hours = n / 3600
     
        n %= 3600
        let minutes = n / 60
     
        n %= 60
        let seconds = n
        todaysTime.text = String(hours) + "h " + String(minutes) + "m " + String(seconds) + "s"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting Labels
        self.futureTextView.delegate = self
        let defaults = UserDefaults.standard
        let text = defaults.object(forKey: "futureText")
        
        futureTextView.text = text as? String
        futureTextView.layer.borderWidth = 0.3
        futureTextView.layer.borderColor = UIColor(named: "Text")?.cgColor
        
        
        let time = defaults.object(forKey: "timeConversion")
        totalTimeLabel.text = time as? String
        
        let drops = defaults.integer(forKey: "drops")
        totalDropsLabel.text = String(drops)
        
        let containerSize = defaults.integer(forKey: "containerSizeName")
        containerSizeLabel.text = String(containerSize)
        
        let x = Double(drops) / Double(containerSize) * 100
        let y = Double(round(100 * x) / 100)
        ratioLabel.text = (String(y) + "%")
        
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        
        // Setting number of drops earned today
        // check if the string date of date is different from the one stored
        // if true then update stored date, change todaysTime to 0, change todaysDrops to 0
        let stored = defaults.object(forKey: "storedDate") as? String
        let current = dateFormatter.string(from: date)
        
        if (current != stored) {
            defaults.set(dateFormatter.string(from: date), forKey: "storedDate")
            defaults.set(0, forKey: "todaysDrops")
            
        }
        dropsToTimeTodayLabel()
        
        
        
        defaults.set(0, forKey: "dropsToday")
        defaults.set(0, forKey: "totalYesterday")
        
        
        
 
        
        var inferredDateInstalledOn: Date? {
            guard
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last,
                let attributes = try? FileManager.default.attributesOfItem(atPath: documentsURL.path)
            else { return nil }
            return attributes[.creationDate] as? Date
        }
        let startDate = dateFormatter.string(from: inferredDateInstalledOn!)
        startDateLabel.text = startDate
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
            let text = "To Future Self:"
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
