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
    @IBOutlet var HighScoreLabel: UILabel!
    @IBOutlet var ScoreLabel: UILabel!
    
    // Buttons
    @IBOutlet var Counter: UIButton!
    @IBOutlet var Reset: UIButton!
    
    // Score labels
    var Score = 0
    var HighScore = 0
    
    // When code launches
    // The high score label should be the last saved High Score from previous use
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let HighscoreDefault = UserDefaults.standard
        
        // if the high score was previously stored, then set the text to that label
        if (HighscoreDefault.value(forKey: "HighScore") != nil) {
            HighScore = HighscoreDefault.value(forKey: "HighScore") as! NSInteger
            HighScoreLabel.text = String(format: "HighScore : %i", HighScore)
        }
    }
    
    // override "didReceiveMemoryWarning" function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Reset Button
    @IBAction func ResetAction(sender: AnyObject) {
        Score = 0
        ScoreLabel.text = String(format: "Score : %i", Score)
    }
    // hello
    // Counter button
    @IBAction func CounterAction(sender: AnyObject) {
        Score+=1
        ScoreLabel.text = String(format: "Score : %i", Score)
        if (Score > HighScore) {
            HighScore = Score
            HighScoreLabel.text = String(format: "High Score : %i", HighScore)
            
            let HighscoreDefault = UserDefaults.standard
            HighscoreDefault.setValue(HighScore, forKey: "HighScore")
            HighscoreDefault.synchronize()
        }
    }
}
