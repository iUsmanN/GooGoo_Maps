//
//  DrawsPath.swift
//  GooGooMaps
//
//  Created by Usman Nazir on 03/08/2019.
//  Copyright © 2019 Usman Nazir. All rights reserved.
//

import Foundation
import GoogleMaps

let DIRECTION_API_KEY = "AIzaSyCxl4gr6gw8u0DeyOqmKFaqrgP1TO4EGp4"

class PathManager : NetworkEngine{
    
    static let shared = PathManager()
    
    //Polylines displayed are stored here
    var polyLine: GMSPolyline?
    
    private init() { }
}

extension PathManager {
    
    func drawPath(mapView: GMSMapView, from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        
        //Get points data from the network engine
        getDirectionsPathData(mapView: mapView, from: from, to: to) { (points) in
            
            //MUST BE DONE ON MAIN THREAD
            DispatchQueue.main.async {
                
                //Convert Points to string format
                guard let pointsString = points as? String else { return }
                
                //Create a path object
                let path = GMSPath(fromEncodedPath: pointsString)
                
                //If there is a path displayed on screen, remove it
                if let polyLine = self.polyLine {
                    polyLine.map = nil
                }
                
                //Draw new polyline
                self.polyLine = GMSPolyline(path: path)
                
                //Set width of polyline
                self.polyLine?.strokeWidth = 5
                
                //Set color of the polyline
                self.polyLine?.strokeColor = .red
                
                //Set map of the polyline
                self.polyLine?.map = mapView
                
                //Set new camera bounds
                let bounds = GMSCoordinateBounds(path: path!)
                
                //Animate camera to show entire path on screen
                mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))
            }
        }
        
    }
}
