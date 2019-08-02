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
        let marker = GMSMarker()
        marker.position = position
        marker.title = title
        marker.map = mapView
        if let icon = icon { marker.icon = UIImage(named: icon) } else { print("No icon defined.") }
        marker.appearAnimation = .pop
    }
}
