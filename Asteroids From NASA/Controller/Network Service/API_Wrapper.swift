//
//  API_Wrapper.swift
//  Asteroids From NASA
//
//  Created by Алексей Россошанский on 04.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import Foundation


struct API_Wrapper {
    
//MARK: - Func to send request
    static func getAsteroidsList(success1 : @escaping (_ json : Any) -> Void, failure : @escaping (_ errorDescription : String) -> Void) -> URLSessionDataTask {
        
        
        let url = Constant.API_URL.baseURL
        let params : [String: Any] = ["start_date": DateSingleton.shared.chosenDate,
                                      "end_date" : DateSingleton.shared.chosenDate,
                                      "api_key": Constant.API_params.apiKey]
        
        
        let request = API_Configurator.createRequest(withURL: url, andParams: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            API_Configurator.generalCompletionHandler(withData: data, withError: error, success: success1, failure: failure)
        }
        dataTask.resume()
        return dataTask
    }
}
