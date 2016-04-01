//
//  ViewController.swift
//  WeatherApp-Swift
//
//  Created by projas on 3/28/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var temperatureSwitch: UISwitch!
    
    private var locationManager: CLLocationManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
        self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager!.requestWhenInUseAuthorization()
        self.locationManager!.startUpdatingLocation()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func refreshLocation(sender: AnyObject) {
        self.locationManager?.startUpdatingLocation()
    }
    
    
    @IBAction func convertTemperatureToAnotherDegree(sender: AnyObject) {
        self.temperatureLabel.text = String(format: "%.0f", WeatherManager.changeTemperatureDegree(self.temperatureLabel.text!, shouldConvertToFarenheit: self.temperatureSwitch.on))
    }

    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.locationManager?.stopUpdatingLocation()
        self.getWeatherForLocation(nil)
        self.adressLabel.text = "Hermosillo, Mexico"
        print("Failed to load location. Error: \(error.description)")
    }
    

    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        LocationManager.getReverseLocationFromLocation(newLocation,forLabel: self.adressLabel)
        self.getWeatherForLocation(newLocation)
        self.locationManager?.stopUpdatingLocation()
    }
    

    func getWeatherForLocation(location: CLLocation?) -> Void {
        
            WeatherViewModel.getWeatherForLocation(location,useCelcius: self.temperatureSwitch.on, completion: { (weather, coordinates) in
                self.temperatureLabel.text = String(format: "%.0f", round(weather.temperature))
                self.latitudeLabel.text = coordinates.latitude
                self.longitudeLabel.text = coordinates.longitude

            }) { (error) in
                print("Error getting weather for location. \(error.description)")
            }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let forecastVC = segue.destinationViewController as! ForecastViewController
        forecastVC.useCelcius = self.temperatureSwitch.on
        forecastVC.coordinates = Coordinates(WithLatitude: self.latitudeLabel.text!, longitude: self.longitudeLabel.text!)
        
    }
}

