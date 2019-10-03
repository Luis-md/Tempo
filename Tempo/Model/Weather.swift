//
//  Weather.swift
//  Tempo
//
//  Created by Luis_md on 25/09/19.
//  Copyright © 2019 Luis_md. All rights reserved.
//

import Foundation
import ObjectMapper

class Weather: Mappable {

    var temperature: Int?
    var tempMin: Int?
    var tempMax: Int?
    var humidity: Double?
    var windSpeed: Double?
    var place: String?
    var pic: String?

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        self.temperature            <- map["main.temp"]
        self.tempMin                <- map["main.temp_min"]
        self.tempMax                <- map["main.temp_max"]
        self.humidity               <- map["main.humidity"]
        self.windSpeed              <- map["wind.speed"]
        self.place                  <- map["name"]
        var picture: Any? = 0
        picture                     <- map["weather"]
        
        if let pic = (picture as? [[String: Any]])?.first?["icon"] as? String {
            self.pic = pic
        }
    }

}
