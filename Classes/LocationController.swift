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
import CoreLocation

class LocationController : CLLocationManager, CLLocationManagerDelegate, AddsMarker {
    
    //Native location manager
    let locationManager = CLLocationManager()
    
    //Map view from the MapViewController
    var mapView : GMSMapView?
    
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
        
        guard let mapView = mapView else { return }
        
        //if authorized
        if status == .authorizedWhenInUse {
            
            //start updating location
            locationManager.startUpdatingLocation()
            
            //shows blue location dot
            mapView.isMyLocationEnabled = true
            
            //shows default location button
            mapView.settings.myLocationButton = true
        }
    }
    
    //4 - Called when location is get
    func locationManager( _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let mapView = mapView else { return }
        
        //get first instance of location
        guard let location = locations.first else { return }
        
        //set camera to point at location
        mapView.animate(to: GMSCameraPosition(target: location.coordinate, zoom: 15))
        mapView.animate(toZoom: 16)
        
        //Add marker for current position on map
        addMarker(mapView: mapView, position: location.coordinate, title: "O", icon: "location")
        
        //stop getting further locations
        locationManager.stopUpdatingLocation()
    }
}
