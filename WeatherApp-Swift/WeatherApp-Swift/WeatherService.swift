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
    
    private static let baseUrl: String = "http://api.openweathermap.org/data/2.5/"
    private static let appId: String = "3504cf10781f6cddd3b6f6dd9413694d"
    private static let numberOfDays: String = "7"
    
    static func getWeatherForLocation(location: CLLocation, useCelcius: Bool, completion: (jsonWeather: [String: AnyObject], coordinates: Coordinates) -> Void, onFailure: (error: NSError) -> Void) -> Void {
        let units = (useCelcius) ? "metric" : "imperial"
        
        let longitude: Double = location.coordinate.longitude
        let latitude: Double = location.coordinate.latitude
        
        
        let coordinates = Coordinates(WithLatitude: String(format: "%.2f", latitude), longitude: String(format: "%.2f", longitude))
        
        let weatherUrl = self.baseUrl + "weather?lat=\(latitude)&lon=\(longitude)&appid=\(appId)&units=\(units)"
        
        Alamofire.request(.GET, weatherUrl, parameters: nil)
            .responseJSON { response in
                
                switch response.result {
                case .Success(let JSON):
                    
                    guard let result = JSON as? [String: AnyObject] else { return}
                    
                    if result["cod"]?.integerValue == 200{
                        completion(jsonWeather: result, coordinates: coordinates)
                    }else{
                        print("Request failed with error: \(result["message"])")
                    }
                    
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    onFailure(error: error)
                }
                
        }
    }
    
    static func getDailyForecast(WithCoordinates coordinates: Coordinates, useCelcius: Bool, completion: (jsonForecast: AnyObject ) -> Void, onFailure: (error: NSError) -> Void ) -> Void {
        
        let coords = coordinates
        let units = (useCelcius) ? "metric" : "imperial"
        let weatherUrl = self.baseUrl + "forecast/daily?lat=\(coords.latitude)&lon=\(coords.longitude)&mode=json&appid=\(appId)&units=\(units)&cnt=\(numberOfDays)"
        
        
        Alamofire.request(.GET, weatherUrl, parameters: nil)
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
