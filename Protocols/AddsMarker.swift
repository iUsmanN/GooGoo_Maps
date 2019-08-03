//
//  AddsMarker.swift
//  GooGooMaps
//
//  Created by Usman Nazir on 02/08/2019.
//  Copyright © 2019 Usman Nazir. All rights reserved.
//

import Foundation
import GoogleMaps

protocol AddsMarker { }

extension AddsMarker {
    
    //Adds a marker to the map
    func addMarker(mapView: GMSMapView, position: CLLocationCoordinate2D, title: String, icon: String?) {
        
        //Create marker
        let marker = GMSMarker()
        
        //Set position of marker
        marker.position = position
        
        //Set title of marker
        marker.title = title
        
        //Set marker to map
        marker.map = mapView
        
        //Set marker icon
        if let icon = icon { marker.icon = UIImage(named: icon) } else { print("No icon defined.") }
        
        //Set marker appear animation
        marker.appearAnimation = .pop
    }
}
