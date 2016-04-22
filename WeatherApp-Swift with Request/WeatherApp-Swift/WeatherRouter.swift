//
//  WeatherRouter.swift
//  WeatherApp-Swift
//
//  Created by projas on 4/19/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import Alamofire

enum WeatherRouter: URLRequestConvertible {
    
    private static let baseUrl: String = "http://api.openweathermap.org/data/2.5/"
    private static let appId: String = "3504cf10781f6cddd3b6f6dd9413694d"
    
    case GetWeatherWithCoordinates(coordinates: Coordinates, useCelcious: Bool)
    case GetDailyForecastWithCoordinates(coordinates: Coordinates, useCelcious: Bool, numberOfDays: Int)
    
    
    var method: Alamofire.Method{
        switch self {
        case .GetDailyForecastWithCoordinates,
             .GetWeatherWithCoordinates:
            return .GET
            
        }
    }
    
    
    
    var path: String{
        switch self {
        case .GetDailyForecastWithCoordinates(let coordinates, let useCelcius, let numberOfDays):
            let units = (useCelcius) ? "metric" : "imperial"
            return "forecast/daily?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&mode=json&appid=\(WeatherRouter.appId)&units=\(units)&cnt=\(numberOfDays)"
            
        case .GetWeatherWithCoordinates(let coordinates, let useCelcius):
            let units = (useCelcius) ? "metric" : "imperial"
            return "weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(WeatherRouter.appId)&units=\(units)"
        }
    }
    
    // MARK: URLRequestConvertible
    var URLRequest: NSMutableURLRequest{
        let url = NSURL(string: WeatherRouter.baseUrl+path)!
        let mutableURLRequest = NSMutableURLRequest(URL: url)
    
        mutableURLRequest.HTTPMethod = method.rawValue
        
        return mutableURLRequest
    }

}
