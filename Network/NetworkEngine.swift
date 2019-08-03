//
//  NetworkEngine.swift
//  GooGooMaps
//
//  Created by Usman Nazir on 03/08/2019.
//  Copyright © 2019 Usman Nazir. All rights reserved.
//

import Foundation
import GoogleMaps

protocol NetworkEngine { }

extension NetworkEngine {
    
    //Gets path using the directions api
    func getDirectionsPathData(mapView: GMSMapView, from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, onSuccess: @escaping (Any?) -> ()) {
        
        let fromStr = "\(from.latitude),\( from.longitude)"
        let toStr = "\(to.latitude),\( to.longitude)"
        
        //Makes final URL
        let url = URL(string : "https://maps.googleapis.com/maps/api/directions/json?origin=" + fromStr + "&destination=" + toStr + "&key=" + DIRECTION_API_KEY)
        
        guard let DirectionsURL = url else { return }
        
        //Makes Data task
        URLSession.shared.dataTask(with: DirectionsURL) {
            (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] {
                    
                    
                    //Parse JSON to get directions
                    let routes = json["routes"] as! NSArray
                    
                    //If there exists at least 1 route, return the value
                    if routes.count != 0 {
                        
                        //Gets "overview_polyline" from the json
                        guard let routeOverviewPolyline = (routes.firstObject as? NSDictionary)?.value(forKey: "overview_polyline") as? NSDictionary else { return }
                        
                        //gets points of the polyline
                        let points = routeOverviewPolyline.object(forKey: "points")
                        
                        //sends the points back to the Path manager
                        onSuccess(points)
                    }
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
            }.resume()
        
    }
    
}
