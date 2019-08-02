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
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Sets color of status bar to white
        setupStatusBarColor()
        
        //Shows map on the screen
        drawMap(mapView: mapView)
        
        //Point to current location
        getUserLocation()
        
        //Place markers
        addMarkers()
    }
    
    //2 - Get user location
    func getUserLocation() {
        
        //sets delegate
        locationManager.delegate = self
        
        //Asks for authorization
        locationManager.requestWhenInUseAuthorization()
    }
    
    //Button to move to current location
    @IBAction func getLocation(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func changeStyle(_ sender: Any) {
        openStyleAlert()
    }
    
    @IBAction func toggleTraffic(_ sender: Any) {
        toggleTrafficOnMap(mapView: mapView)
    }
}

extension MapViewController : CLLocationManagerDelegate {
    
    //3 - updates map on authorization of location access
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        //if authorized
        if status == .authorizedWhenInUse {
            
            //start updating location
            locationManager.startUpdatingLocation()
            
            //shows blue location dot
            mapView.isMyLocationEnabled = true
            
            //shows default location button
            mapView.settings.myLocationButton = false
        }
    }
    
    //4 - Called when location is get
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //get first instance of location
        guard let location = locations.first else { return }
        
        //set camera to point at location
        mapView.animate(to: GMSCameraPosition(target: location.coordinate, zoom: 15))
        mapView.animate(toZoom: 16)
        
        //stop getting further locations
        locationManager.stopUpdatingLocation()
    }
}

extension MapViewController : AddsMarker {
    
    //Adds Marker to the map
    func addMarkers() {
        //Marker for home
        addMarker(mapView: mapView, position: CLLocationCoordinate2D(latitude: 31.584333, longitude: 74.466217), title: "Home", icon: nil)
        
        //Marker for Office
        addMarker(mapView: mapView, position: CLLocationCoordinate2D(latitude: 31.533793, longitude: 74.328561), title: "Office", icon: nil)
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
        alert.addAction(UIAlertAction(title: "Google", style: .default, handler: { (action) in
            self.setTheme(mapView: self.mapView, name: "google_standard")
        }))
        
        //Add Dark theme
        alert.addAction(UIAlertAction(title: "Dark", style: .default, handler: { (action) in
            self.setTheme(mapView: self.mapView, name: "dark")
        }))
        
        //Add Silver theme
        alert.addAction(UIAlertAction(title: "Silver", style: .default, handler: { (action) in
            self.setTheme(mapView: self.mapView, name: "silver")
        }))
        
        //Add Retro theme
        alert.addAction(UIAlertAction(title: "Retro", style: .default, handler: { (action) in
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
