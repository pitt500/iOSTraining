//
//  ViewController.swift
//  HonoluluArt
//
//  Created by projas on 4/22/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    //1000 Meters - 1 KM
    let regionRadius: CLLocationDistance = 1000
    var artworks = [Artwork]()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
        
        loadInitialData()
        mapView.addAnnotations(artworks)
        mapView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadInitialData(){
        let filename = NSBundle.mainBundle().pathForResource("PublicArt", ofType: "json")
        let data = try! NSData(contentsOfFile: filename!, options: .DataReadingMapped)
        
        let jsonObject: AnyObject! = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        
        guard let jsonObj = jsonObject as? [String: AnyObject]
            else{   return  }
        
        guard let jsonData = JSONValue.fromObject(jsonObj)?["data"]?.array
            else{ return }
        
        for artworkJSON in jsonData {
            if let artworkJSON = artworkJSON.array, artwork = Artwork.fromJSON(artworkJSON) {
                artworks.append(artwork)
            }
        }
    }
    
    //MARK: - location manager to authorize user location for Maps app
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }


}

