//
//  Coordinates.swift
//  WeatherApp-Swift
//
//  Created by projas on 3/28/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import CoreLocation

class Coordinates: NSObject {
    var latitude:   String
    var longitude:  String
    
    init(WithLatitude latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
