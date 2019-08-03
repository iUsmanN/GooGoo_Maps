//
//  LocationController.swift
//  GooGooMaps
//
//  Created by Usman Nazir on 02/08/2019.
//  Copyright © 2019 Usman Nazir. All rights reserved.
//

import Foundation
import GoogleMaps
import UIKit

class LocationController : CLLocationManager, CLLocationManagerDelegate, AddsMarker {
    
    //Native location manager
    let locationManager = CLLocationManager()
    
    //Map view from the MapViewController
    var mapView         : GMSMapView?
    
    //Set map object
    func setMap(map: GMSMapView) {
        mapView = map
    }
    
    //Start updating location
    func UpdateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func getUserLocationPermission() {
        
        //sets delegate
        locationManager.delegate = self
        
        //Asks for authorization
        locationManager.requestWhenInUseAuthorization()
    }
    
    //3 - updates map on authorization of location access
    func locationManager( _ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        //if authorized
        if status == .authorizedWhenInUse {
            
            //start updating location
            locationManager.startUpdatingLocation()
        }
    }
    
    //4 - Called when location is get
    func locationManager( _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let mapView = mapView else { return }
        
        //get first instance of location
        guard let location = locations.first else { return }
        
        //set camera to point at location
        mapView.animate(to: GMSCameraPosition(target: location.coordinate, zoom: 16))
        
        //stop getting further locations
        locationManager.stopUpdatingLocation()
    }
}
