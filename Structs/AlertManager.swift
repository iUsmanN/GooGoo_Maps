//
//  GetsAlert.swift
//  GooGooMaps
//
//  Created by Usman Nazir on 03/08/2019.
//  Copyright © 2019 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

struct AlertManager : StylesMap {
    
    //mapView object. Initialized to avoid guard let statements. Instance is automatically deleted by ARC on init
    var mapView = GMSMapView()
    
    //Initialize Alert Manager
    init(map: GMSMapView) {
        
        //Set map view
        mapView = map
    }
    
}

extension AlertManager {
    
    //Returns the Alert View Controlelr with Styles actions
    func StylesAlert() -> UIAlertController {
        
        let alert = UIAlertController()
        
        //Add Google theme
        alert.addAction(UIAlertAction(title: "Google", style: .default, handler: { _ in
            self.setTheme(mapView: self.mapView, name: "Style_google_standard")
        }))
        
        //Add Dark theme
        alert.addAction(UIAlertAction(title: "Dark", style: .default, handler: { _ in
            self.setTheme(mapView: self.mapView, name: "Style_dark")
        }))
        
        //Add Silver theme
        alert.addAction(UIAlertAction(title: "Silver", style: .default, handler: { _ in
            self.setTheme(mapView: self.mapView, name: "Style_silver")
        }))
        
        //Add Retro theme
        alert.addAction(UIAlertAction(title: "Retro", style: .default, handler: { _ in
            self.setTheme(mapView: self.mapView, name: "Style_retro")
        }))
        
        //Add Gold theme
        alert.addAction(UIAlertAction(title: "Gold", style: .default, handler: { _ in
            self.setTheme(mapView: self.mapView, name: "Style_gold")
        }))
        
        //Add Red theme
        alert.addAction(UIAlertAction(title: "Red", style: .default, handler: { _ in
            self.setTheme(mapView: self.mapView, name: "Style_red")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        return alert
    }
}
