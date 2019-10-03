//
//  WeatherViewModel.swift
//  Tempo
//
//  Created by Luis_md on 26/09/19.
//  Copyright © 2019 Luis_md. All rights reserved.
//

import Foundation

struct WeatherView {
    
    var temperature = 0
    var tempMin = 0
    var tempMax = 0
    var humidity = 0.0
    var windSpeed = 0.0
    var place = ""
    var pic = ""
    
    var urlImg: URL? {
        return URL(string: "http://openweathermap.org/img/wn/\(self.pic)@2x.png")
    }
}


class WeatherViewModel {
    
    static func getAsView(weather: Weather?) -> WeatherView {
        
        guard let weather = weather else {
            
            return WeatherView()
        }
        
        var weatherView = WeatherView()
        weatherView.temperature = weather.temperature ?? 0
        weatherView.tempMin = weather.tempMin ?? 0
        weatherView.tempMax = weather.tempMax ?? 0
        weatherView.humidity = weather.humidity ?? 0.0
        weatherView.windSpeed = weather.windSpeed ?? 0.0
        weatherView.place = weather.place ?? ""
        weatherView.pic = weather.pic ?? ""
        
        return weatherView
    }
}
