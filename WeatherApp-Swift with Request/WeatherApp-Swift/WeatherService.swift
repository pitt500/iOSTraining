//
//  WeatherService.swift
//  WeatherApp-Swift
//
//  Created by projas on 3/31/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherService: NSObject {
    
    static func getWeatherForLocation(location: CLLocation, useCelcius: Bool, completion: (jsonWeather: [String: AnyObject], coordinates: Coordinates) -> Void, onFailure: (error: NSError) -> Void) -> Void {
        
        let longitude: Double = location.coordinate.longitude
        let latitude: Double = location.coordinate.latitude
        let coordinates = Coordinates(WithLatitude: String(format: "%.2f", latitude), longitude: String(format: "%.2f", longitude))
        
        
        Alamofire.request(WeatherRouter.GetWeatherWithCoordinates(coordinates: coordinates, useCelcious: useCelcius))
            .responseJSON { response in
                
                switch response.result {
                case .Success(let JSON):
                    
                    guard let result = JSON as? [String: AnyObject] else { return}
                    
                    if result["cod"]?.integerValue == 200{
                        completion(jsonWeather: result, coordinates: coordinates)
                    }else{
                        print("Request failed with error: \(result["message"]!)")
                        onFailure(error: NSError(domain: "Weather.Nearsoft", code: -1, userInfo: ["message": result["message"]! ]))
                    }
                    
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    onFailure(error: error)
                }
                
        }
        
    }
    
    static func getDailyForecast(WithCoordinates coordinates: Coordinates, useCelcius: Bool, completion: (jsonForecast: AnyObject ) -> Void, onFailure: (error: NSError) -> Void ) -> Void {
        
        let numberOfDays = 7
        Alamofire.request(WeatherRouter.GetDailyForecastWithCoordinates(coordinates: coordinates, useCelcious: useCelcius, numberOfDays: numberOfDays))
            .responseJSON { response in
                
                switch response.result {
                case .Success(let JSON):
                    
                    guard let result = JSON["list"] as? [AnyObject]
                        else {
                            print("Error getting json array")
                            return
                    }
                    
                    completion(jsonForecast: result)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    onFailure(error: error)
                }
        }
        
    }


}
