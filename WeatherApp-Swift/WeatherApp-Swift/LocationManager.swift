//
//  LocationManager.swift
//  WeatherApp-Swift
//
//  Created by projas on 3/31/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {

    static func getReverseLocationFromLocation(location: CLLocation, forLabel: UILabel) -> Void {
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            if placemarks?.count > 0 && error == nil{
                let placemark = placemarks?.last
                
                if let city = placemark?.locality, country = placemark?.country{
                    forLabel.text = "\(city), \(country)"
                }
            }else{
                print("Error getting location. \(error?.description)")
            }
        })
    }


}
