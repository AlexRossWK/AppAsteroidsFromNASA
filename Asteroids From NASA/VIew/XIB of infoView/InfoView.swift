//
//  infoView.swift
//  Asteroids From NASA
//
//  Created by Алексей Россошанский on 06.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import UIKit

class InfoView: UIView {

    @IBOutlet weak var viewWithInfo: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var minDiamLabel: UILabel!
    @IBOutlet weak var maxDiamLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("InfoView", owner: self, options: nil)
        addSubview(viewWithInfo)
        viewWithInfo.frame = self.bounds
        viewWithInfo.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        viewWithInfo.layer.masksToBounds = true
        viewWithInfo.layer.cornerRadius = 10
        viewWithInfo.layer.borderWidth = 1
        viewWithInfo.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

}
