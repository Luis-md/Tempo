//
//  GetWeatherService.swift
//  Tempo
//
//  Created by Luis_md on 25/09/19.
//  Copyright © 2019 Luis_md. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

protocol GetWeatherDelegate {
    func success(weather: Weather)
    func failure(error: String)
}


class GetWeatherService {
    
    var delegate: GetWeatherDelegate!
    init(delegate: GetWeatherDelegate) {
        self.delegate = delegate
    }
    
    func getWeather (lat: String, lon: String) {
        
        GetWeatherRequestFactory.getWeather(lat: lat, lon: lon).validate().responseObject { (response: DataResponse<Weather>) in
            
            switch response.result {
            case .success:
                
                if let weather = response.result.value {
                    print(weather)
                    self.delegate.success(weather: weather)
                }
                
            case .failure(let error):
                
                self.delegate.failure(error: error.localizedDescription)
            }
            
        }
    }
    
}
