//
//  Current date.swift
//  Asteroids From NASA
//
//  Created by Алексей Россошанский on 10.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import Foundation

class CurrentDate {
    //Determines current date in form we need
    static func today() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        DateSingleton.shared.chosenDate = result
    }
    
}
