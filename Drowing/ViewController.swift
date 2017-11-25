//
//  ViewController.swift
//  Drowing
//
//  Created by techno krishna on 22/11/17.
//  Copyright © 2017 techno krishna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var lastPoint = CGPoint.zero
    var red: CGFloat = 10.0
    var green: CGFloat = 50.0
    var blue: CGFloat = 80.0
    var brushWidth: CGFloat = 10.0
    var color: UIColor  = UIColor.black
    var opacity: CGFloat = 1.0
    var swiped = false
    
    @IBOutlet weak var drowingPad: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
         UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        drowingPad.image?.draw(in: view.bounds)
        
    let context = UIGraphicsGetCurrentContext()
        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(color.cgColor)//(red: red, green: green, blue: blue, alpha: 1.0)
        context?.setBlendMode(CGBlendMode.normal)
        context?.strokePath()
        
        drowingPad.image = UIGraphicsGetImageFromCurrentImageContext()
        drowingPad.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first as UITouch? {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first as UITouch? {
            let currentPoint = touch.location(in: view)
            drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        }
    }
    
    @IBAction func changeColor(_ sender: UIButton) {
        self.color = sender.backgroundColor!
        self.brushWidth = 10
    }
    
    @IBAction func eraser(_ sender: UIButton) {
        self.color = UIColor.white
        self.brushWidth = 20
    }
}

