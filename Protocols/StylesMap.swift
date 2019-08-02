//
//  StylesMap.swift
//  GooGooMaps
//
//  Created by Usman Nazir on 02/08/2019.
//  Copyright © 2019 Usman Nazir. All rights reserved.
//

import Foundation
import GoogleMaps

protocol StylesMap { }

extension StylesMap {
    
    //Sets the Map Theme
    func setTheme(mapView:GMSMapView, name: String) {
        do {
            if let styleJSON = Bundle.main.url(forResource: "\(name)", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleJSON)
            }
        } catch {
            print("Error in styling")
        }
    }
    
}
