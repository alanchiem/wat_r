//
//  DrawingViewController.swift
//  wat_r
//
//  Created by Alan Chiem on 3/12/22.
//

import UIKit

class DrawingViewController: UIViewController {
    // Hides Time, Wifi, Battery
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var backButtonOutlet: UIButton!
    
    
    let canvas = Canvas()
    
    
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    } ()
    
    
    @objc fileprivate func handleUndo() {
        canvas.undo()
    }
    
    
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    } ()
    
    
    @objc fileprivate func handleClear() {
        canvas.clear()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvas)
        canvas.backgroundColor = .clear
        canvas.frame = view.frame
        
        view.bringSubviewToFront(backButtonOutlet)
        
        
        // Setup undo and clear buttons
        let stackView = UIStackView(arrangedSubviews: [undoButton, clearButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    


}
