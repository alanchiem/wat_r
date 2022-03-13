//
//  Canvas.swift
//  wat_r
//
//  Created by Alan Chiem on 3/12/22.
//

import UIKit

class Canvas: UIView {
    
    // Public Function
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    fileprivate var lines = [[CGPoint]]()
    
    
    override func draw(_ rect: CGRect) {
        // custom drawing
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return}
        
// lines
//        let startPoint = CGPoint(x: 0, y: 0)
//        let endPoint = CGPoint(x: 100, y: 100)
//        context.move(to: startPoint)
//        context.addLine(to: endPoint)
        
        context.setStrokeColor(UIColor(named: "Background")!.cgColor)
        context.setLineWidth(7)
        context.setLineCap(.round)
        
        lines.forEach{ (line) in
            for (i,p) in line.enumerated() {
                if (i == 0) {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    // tracks finger
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
        
    }
    
}
