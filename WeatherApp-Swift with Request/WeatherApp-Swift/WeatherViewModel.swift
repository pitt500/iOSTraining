//
//  WeatherViewModel.swift
//  WeatherApp-Swift
//
//  Created by projas on 3/31/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import CoreLocation
import ObjectMapper

class WeatherViewModel: NSObject {
    static func getWeatherForLocation(location: CLLocation?, useCelcius: Bool, completion: (weather: Weather, coordinates: Coordinates) -> Void, onFailure: (error: NSError) -> Void) -> Void {
        
        
        var actualLocation = CLLocation(latitude: 29.07, longitude: -110.97)
        if location != nil {
            actualLocation = location!
        }

        WeatherService.getWeatherForLocation(actualLocation, useCelcius: useCelcius, completion: { (jsonWeather, coordinates) in
                if let temperature = jsonWeather["main"]!["temp"] as? Double{
                    let aWeather = Weather(WithTemperature: temperature)
                    completion(weather: aWeather, coordinates: coordinates)
                }else{
                    print("Failed to create Weather object.")
                }
            }) { (error) in
                onFailure(error: error)
            }
    }
    
    static func getDailyForecast(WithCoordinates coordinates: Coordinates, useCelcius: Bool, completion: (forecast: [Weather]) -> Void, onFailure: (error: NSError) -> Void ) -> Void {
        WeatherService.getDailyForecast(WithCoordinates: coordinates, useCelcius: useCelcius, completion: { (jsonForecast) in
                let listForecast: Array<Weather> = Mapper<Weather>().mapArray(jsonForecast)!
                completion(forecast: listForecast)
            }) { (error) in
                onFailure(error: error)
            }
        
    }
}
