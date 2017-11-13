//
//  AsteroidModel.swift
//  Asteroids From NASA
//
//  Created by Алексей Россошанский on 04.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import Foundation


class AsteroidModel {
    
    let name: String
    let minEstimatedDiameterMeters: Double
    let maxEstimatedDiameterMeters: Double
    var averageOfestimatedDiametr: Double {
        let result = (minEstimatedDiameterMeters+maxEstimatedDiameterMeters)/2
        return result
    }
    let hazard: String
    let missDistanceKM: Double
    let orbitingBody: String
    
    
    init(name: String, minEstimatedDiameterMeters: Double, maxEstimatedDiameterMeters: Double, hazard: String, missDistanceKM: Double, orbitingBody: String) {
        
        self.name = name
        self.minEstimatedDiameterMeters = minEstimatedDiameterMeters
        self.maxEstimatedDiameterMeters = maxEstimatedDiameterMeters
        self.hazard = hazard
        self.missDistanceKM = missDistanceKM
        self.orbitingBody = orbitingBody
        
    }
}
