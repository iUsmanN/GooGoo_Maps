//
//  MapViewController.swift
//  GooGooMaps
//
//  Created by Usman Nazir on 30/07/2019.
//  Copyright © 2019 Usman Nazir. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, DrawsMap, DisplaysTraffic {
    
    //view of the map
    @IBOutlet weak var mapView: GMSMapView!
    
    //Used to manage user location
    let locationController = LocationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Sets color of status bar to white
        setupStatusBarColor()
        
        //Shows map on the screen
        drawMap(mapView: mapView)
        
        //Point to current location
        locationController.getUserLocationPermission()
        
        //Place markers
        addMarkers()
    }
    
    //Button to move to current location
    @IBAction func getLocation(_ sender: Any) {
        
        locationController.setMap(map: mapView)
        locationController.UpdateLocation()
    }
    
    //Button to change the map style
    @IBAction func changeStyle(_ sender: Any) {
        openStyleAlert()
    }
    
    //Button to toggle traffic on the map
    @IBAction func toggleTraffic(_ sender: Any) {
        toggleTrafficOnMap(mapView: mapView)
    }
}

extension MapViewController : AddsMarker {
    
    //Adds Marker to the map
    func addMarkers() {
        //Marker for home
        addMarker(mapView: mapView, position: CLLocationCoordinate2D(latitude: 31.584333, longitude: 74.466217), title: "Home", icon: nil)
    }
}

//Color Status Bar
extension MapViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupStatusBarColor() {
        self.setNeedsStatusBarAppearanceUpdate()
    }
}

extension MapViewController : StylesMap {
    
    //Presents Options to choose style
    func openStyleAlert() {
        
        //Open Alert Controller to select style
        let alert = UIAlertController()
        
        //Add Google theme
        alert.addAction(UIAlertAction(title: "Google", style: .default, handler: { _ in
            self.setTheme(mapView: self.mapView, name: "google_standard")
        }))
        
        //Add Dark theme
        alert.addAction(UIAlertAction(title: "Dark", style: .default, handler: { _ in
            self.setTheme(mapView: self.mapView, name: "dark")
        }))
        
        //Add Silver theme
        alert.addAction(UIAlertAction(title: "Silver", style: .default, handler: { _ in
            self.setTheme(mapView: self.mapView, name: "silver")
        }))
        
        //Add Retro theme
        alert.addAction(UIAlertAction(title: "Retro", style: .default, handler: { _ in
            self.setTheme(mapView: self.mapView, name: "retro")
        }))
        
        //Add Gold theme
        alert.addAction(UIAlertAction(title: "Gold", style: .default, handler: { _ in
            self.setTheme(mapView: self.mapView, name: "gold")
        }))
        
        //Add Red theme
        alert.addAction(UIAlertAction(title: "Red", style: .default, handler: { _ in
            self.setTheme(mapView: self.mapView, name: "red")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
}
