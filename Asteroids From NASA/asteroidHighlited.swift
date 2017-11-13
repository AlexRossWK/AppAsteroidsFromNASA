//
//  asteroidHighlited.swift
//  Asteroids From NASA
//
//  Created by Алексей Россошанский on 06.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import Foundation
import UIKit

class ResizibleView: UIControl {
    
    let sizeMultiplier: CGFloat = 20
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 1) {
            self.frame.size = CGSize(width: self.frame.size.width + self.sizeMultiplier, height: self.frame.size.height + self.sizeMultiplier)
            
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 1) {
            
            self.frame.size = CGSize(width: self.frame.size.width - self.sizeMultiplier, height: self.frame.size.height - self.sizeMultiplier)
        }
    }
    
    
    
}
