//
//  EasterEggViewController.swift
//  wat_r
//
//  Created by Alan Chiem on 3/11/22.
//

import UIKit

class EasterEggViewController: UIViewController {

    @IBOutlet weak var easterEggImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var image = UIImage(named: "lightEasterEgg.jpg")
        if UITraitCollection.current.userInterfaceStyle == .dark {
            image = UIImage(named: "darkEasterEgg.jpg")
        }
        
        easterEggImage.image = image

 
    }
    



}
