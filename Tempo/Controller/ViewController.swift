//
//  ViewController.swift
//  Tempo
//
//  Created by Luis_md on 25/09/19.
//  Copyright © 2019 Luis_md. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import Kingfisher
import SVProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var tempView: UILabel!
    @IBOutlet weak var tempImage: UIImageView!
    var lon: String = ""
    var lat: String = ""

    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var umidade: UILabel!
    @IBOutlet weak var vento: UILabel!
    
    @IBOutlet weak var weatherImg: UIImageView!
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var cityName: UILabel!
    var getWeatherService: GetWeatherService!
    var weatherView: WeatherView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getWeatherService = GetWeatherService(delegate: self)

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.tempView.text = "Loading..."
        self.cityName.text = ""
        self.max.text = "-"
        self.min.text = "-"
        self.vento.text = "-"
        self.umidade.text = "-"
        SVProgressHUD.show()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
}


extension ViewController: GetWeatherDelegate {
    func success(weather: Weather) {
        SVProgressHUD.dismiss()
        print("Success")
        self.weatherView = WeatherViewModel.getAsView(weather: weather)
        
        if let temp = weatherView { 
            self.tempView.text = "\(temp.temperature - 273)°C"
            self.cityName.text = "\(temp.place)"
            self.max.text = "\(temp.tempMax - 273)°C"
            self.min.text = "\(temp.tempMin - 273)°C"
            self.umidade.text = "\(temp.humidity)%"
            self.vento.text = "\(temp.windSpeed)"
            self.weatherImg.kf.setImage(with: temp.urlImg)
            
        }
    }
    
    func failure(error: String) {
        SVProgressHUD.dismiss()
        self.tempView.text = "No internet connection.."
        self.tempView.font = UIFont.systemFont(ofSize: 25)
        print(error)
    }
    
    
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue = locations[locations.count - 1]
        print("entrou aqui")
        if locValue.horizontalAccuracy > 0 {
            self.locationManager.stopUpdatingLocation()
            
            self.lat = String(locValue.coordinate.latitude)
            self.lon = String(locValue.coordinate.longitude)
        }
        self.getWeatherService.getWeather(lat: self.lat, lon: self.lon)
    }
}
