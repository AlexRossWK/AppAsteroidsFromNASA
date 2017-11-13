//
//  GetAsteroidsManager.swift
//  Asteroids From NASA
//
//  Created by Алексей Россошанский on 04.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import Foundation
import SwiftyJSON


class GetAsteroidsManager {
    //Mark: Func to create array of asteroids
    static func getList(success: @escaping (_ asteroids: [AsteroidModel] ) -> Void, failure: @escaping (_ errorDescription: String) -> Void) {
        
        _ = API_Wrapper.getAsteroidsList(success1: { (response) in
            
            var asteroidsArray = [AsteroidModel]()
            var filtredAndSortedByDistanceAsteroidsArray = [AsteroidModel]()
            
            let jsonResponse = JSON(response)
            
            let arrayOfJSONAsteroids = jsonResponse["near_earth_objects"][DateSingleton.shared.chosenDate].arrayValue
            
            for asteroid in arrayOfJSONAsteroids {
                
                let name = asteroid["name"].stringValue
                let minEstimatedDiameterMeters = asteroid["estimated_diameter"]["meters"]["estimated_diameter_min"].doubleValue
                let maxEstimatedDiameterMeters = asteroid["estimated_diameter"]["meters"]["estimated_diameter_max"].doubleValue
                let hazard = asteroid["is_potentially_hazardous_asteroid"].stringValue
                let missDistanceKM = asteroid["close_approach_data"][0]["miss_distance"]["kilometers"].doubleValue
                let orbitingBody = asteroid["close_approach_data"][0]["orbiting_body"].stringValue
                
                let newAsteroid = AsteroidModel(name: name, minEstimatedDiameterMeters: minEstimatedDiameterMeters, maxEstimatedDiameterMeters: maxEstimatedDiameterMeters, hazard: hazard, missDistanceKM: missDistanceKM, orbitingBody: orbitingBody)

                asteroidsArray.append(newAsteroid)
                
            }
            //MARK: Filter and Sort results (sortod from largest to smallest)
            filtredAndSortedByDistanceAsteroidsArray = asteroidsArray.filter{i in i.orbitingBody == "Earth"}.sorted(by: { $0.missDistanceKM > $1.missDistanceKM })
           
            
            success(filtredAndSortedByDistanceAsteroidsArray)
            
        }) { (errorDescrption) in

            failure(errorDescrption)
            
        }
        
    }
    
}








