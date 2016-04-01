//
//  Weather.swift
//  WeatherApp-Swift
//
//  Created by projas on 3/28/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import ObjectMapper

class Weather: Mappable {
    
    var temperature: Double = 0.0
    var maxTemperature: Double = 0.0
    var minTemperature: Double = 0.0
    var date: NSDate?
    
    init(WithTemperature temperature: Double){
        self.temperature = temperature
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        temperature         <- map["temp.day"]
        maxTemperature      <- map["temp.max"]
        minTemperature      <- map["temp.min"]
        date                <- (map["dt"], DateTransform())
    }

}
