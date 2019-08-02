//
//  DisplaysTraffic.swift
//  GooGooMaps
//
//  Created by Usman Nazir on 02/08/2019.
//  Copyright © 2019 Usman Nazir. All rights reserved.
//

import Foundation
import GoogleMaps

protocol DisplaysTraffic { }

extension DisplaysTraffic {
    
    //Sets the traffic on map
    func toggleTrafficOnMap(mapView:GMSMapView) {
        if mapView.isTrafficEnabled == true {
            mapView.isTrafficEnabled = false
        } else {
            mapView.isTrafficEnabled = true
        }
    }
}
