//
//  Artwork.swift
//  HonoluluArt
//
//  Created by projas on 4/22/16.
//  Copyright © 2016 projas. All rights reserved.
//

import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    var subtitle: String?{
        return locationName
    }
    
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    
    func mapItem() -> MKMapItem{
        let addressDictionary = [String(CNPostalAddressStreetKey): subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        
        
        return mapItem
    }
    
    class func fromJSON(json: [JSONValue]) -> Artwork?{
        var title: String
        if let titleOrNil = json[16].string{
            title = titleOrNil
        }else{
            title = ""
        }
        
        let locationName = json[12].string!
        let discipline = json[15].string!
        
        let latitude = Double(json[18].string!)
        let longitude = Double(json[19].string!)
        let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        
        
        return Artwork(title: title, locationName: locationName, discipline: discipline, coordinate: coordinate)
    }
    
    func pinColor() -> UIColor {
        switch discipline {
        case "Sculpture", "Plaque":
            return MKPinAnnotationView.redPinColor()
        case "Mural", "Monument":
            return MKPinAnnotationView.purplePinColor()
        default:
            return MKPinAnnotationView.greenPinColor()
        }
    }
    
    
}
