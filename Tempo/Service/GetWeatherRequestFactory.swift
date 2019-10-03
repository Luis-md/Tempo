//
//  GetWeatherRequestFactory.swift
//  Tempo
//
//  Created by Luis_md on 25/09/19.
//  Copyright © 2019 Luis_md. All rights reserved.
//

import Foundation
import Alamofire

class GetWeatherRequestFactory {
    
    static func getWeather (lat: String, lon: String) -> DataRequest {
        
        let params: [String : String] = [
            "lat" : lat,
            "lon" : lon,
            "appid" : apiKey,
        ]
        
        return Alamofire.request(baseUrl, method: .get, parameters: params, encoding: URLEncoding.default)
    }
}
