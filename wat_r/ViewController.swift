//
//  ViewController.swift
//  wat_r
//
//  Created by Alan Chiem on 1/12/21.
//

import UIKit
import Foundation
import Lottie

class ViewController: UIViewController {
    
    var OurTimer = Timer()
    var timerDisplayed = 0
    
    // Animation
    let animationView = AnimationView()

    
    
    @IBAction func StartBTN(_ sender: Any) {
        OurTimer = Timer.scheduledTimer(timeInterval: 2,
                                        target: self,
                                        selector: #selector(Action),
                                        userInfo: nil,
                                        repeats: true)
    }
    
    
    @IBAction func PauseBTN(_ sender: Any) {
        OurTimer.invalidate()
        animationView.pause()
    }
    
    
    
    @IBAction func ResetBTN(_ sender: Any) {
        OurTimer.invalidate()
        timerDisplayed = 0
        Label.text = "0"
        setupAnimation()
        animationView.pause()
    }
    
    
    @objc func Action() {
        timerDisplayed += 1
        setupAnimation()
        Label.text = String(timerDisplayed)
    }
    
    
    @IBOutlet weak var Label: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Animation cont
        setupAnimation()
        animationView.pause()
        
    }
    
    private func setupAnimation() {
        animationView.animation = Animation.named("falling-drop-of-water")
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
}
