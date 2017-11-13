//
//  GradientAndStars.swift
//  Asteroids From NASA
//
//  Created by Алексей Россошанский on 06.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import Foundation
import UIKit

class GradientAndStars {
    
    //MARK: Dots on View
    static func configStarLayer(_ shapeLayer: CAShapeLayer, view: UIView) {
        
        shapeLayer.lineWidth = 1
        shapeLayer.lineCap = "round"
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        shapeLayer.frame = view.bounds
        let path = UIBezierPath()
        //Create 300 stars
        for _ in 0...300 {
            let coordinate = CGFloat(arc4random_uniform(UInt32(view.frame.width)))
            let secCoordinate = CGFloat(arc4random_uniform(UInt32(view.frame.width)))
            //Point at random place
            path.move(to: CGPoint(x: coordinate, y: secCoordinate))
            path.addLine(to: CGPoint(x: coordinate, y: secCoordinate))
        }
        shapeLayer.path = path.cgPath
        
        //Animation for stars
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 1.4
        
        // Animation option
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                
        shapeLayer.add(animation, forKey: nil)
        
        
    }
    
    //MARK: Gradient
    static func configGradientLayer(_ gradientLayer: CAGradientLayer){
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        let startColor = #colorLiteral(red: 0.0571770363, green: 0.02667106526, blue: 0.6036841687, alpha: 1).cgColor
        let middleColor = #colorLiteral(red: 0.08485422149, green: 0.002700965611, blue: 0.4902839467, alpha: 1).cgColor
        let endColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1).cgColor
        gradientLayer.colors = [startColor, middleColor, endColor]
    }
    
    
    
}
