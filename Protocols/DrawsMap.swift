//
//  GoogleMap.swift
//  GooGooMaps
//
//  Created by Usman Nazir on 02/08/2019.
//  Copyright © 2019 Usman Nazir. All rights reserved.
//

import Foundation
import GoogleMaps

protocol DrawsMap { }

extension DrawsMap {
    
    //Draws the map in the given mapView
    func drawMap(mapView: GMSMapView) {
        let camera = GMSCameraPosition(latitude: 31.5337954, longitude: 74.3263944, zoom: 17)
        mapView.camera = camera
    }
}
