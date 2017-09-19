//
//  ViewController.swift
//  Weather
//
//  Created by Dovran on 19.09.17.
//  Copyright © 2017 Dovran Reyimov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBAction func refreshButtonTaped(_ sender: UIButton) {
        getCurrentWeatherData()
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func toggleActivityIndicator(on:Bool) {
        refreshButton.isHidden = on
        
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    lazy var weatherManager = APIWeatherManager(apiKey: "2a6d8e376a69c1ae07d4a52dd0c2dfdc")
    let coordinates = Coordinates(latitude: 37.95, longitude: 58.38333)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentWeatherData()
        
        
    }
    
    //Weather
    func updateUIWith(currentWeather : CurrentWeather) {
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.appearentTemperatureLabel.text = currentWeather.appearentTemperatureString
        self.humidityLabel.text = currentWeather.humidityString
    }
    
    //ActivityIndicator
    func getCurrentWeatherData() {
        
        //Weather
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
            self .toggleActivityIndicator(on: false)
            
            switch result {
            case .Success(let currentWeather):
                self.updateUIWith(currentWeather: currentWeather)
            case .Failure(let error as NSError):
                
                let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController,animated: true, completion: nil)
            default: break
                
            }
            
            
        }
    }
    
    
}

