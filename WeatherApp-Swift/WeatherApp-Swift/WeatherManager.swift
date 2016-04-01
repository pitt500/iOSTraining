//
//  WeatherManager.swift
//  WeatherApp-Swift
//
//  Created by projas on 3/29/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit

class WeatherManager: NSObject {
    
    static func convertFromFarenheitToCelciusWithTemperature(temperature: Double) -> Double {
        return (temperature * 1.8) + 32
    }
    
    static func convertFromCelciusToFarenheitWithTemperature(temperature: Double) -> Double {
        return (temperature - 32)*5/9
    }
    
    static func changeTemperatureDegree(temperature: String, shouldConvertToFarenheit: Bool) -> Double {
        let actualTemperature = Double(temperature)
        let newTemperature = (shouldConvertToFarenheit) ? WeatherManager.convertFromCelciusToFarenheitWithTemperature(actualTemperature!) : WeatherManager.convertFromFarenheitToCelciusWithTemperature(actualTemperature!)
        return newTemperature
    }
}
