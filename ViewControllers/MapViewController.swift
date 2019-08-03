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
        
        /// Do any additional setup after loading the view.
        
        //Set delegate of the Map
        mapView.delegate = self
        
        //Sets color of status bar to white
        setupStatusBarColor()
        
        //Shows map on the screen
        drawMap(mapView: mapView)
        
        //Load Map Style
        loadInitialStyle(mapView: mapView)
        
        //Set map in location controller
        locationController.setMap(map: mapView)
        
        //Permission to get current location
        locationController.getUserLocationPermission()
        
        //Place markers
        addMarkers()
        
        //Point to current location
        getLocation(nil)
    }
    
    //Button to move to current location
    @IBAction func getLocation(_ sender: Any?) {
        
        //Update location
        locationController.UpdateLocation()
        
        //shows blue location dot
        mapView.isMyLocationEnabled = true
        
        //shows default location button
        mapView.settings.myLocationButton = false
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
        addMarker(mapView: mapView, position: CLLocationCoordinate2D(latitude: 31.584333, longitude: 74.466217), title: "Home", icon: "cross")
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
        
        //Object to handle alert view code
        let alertView = AlertManager(map: mapView)
        
        //Get the styles Alert view controller
        let stylesAlert = alertView.StylesAlert()
        
        //Present the styles alert controller
        present(stylesAlert, animated: true)
    }
}

extension MapViewController : GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        print("Tapped my location")
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate)
        
        //Add temporary marker
        addMarker(mapView: mapView, position: coordinate, title: "X", icon: nil)
        
        //Animate the map so that the point is a little bit above the center of the screen
        mapView.animate(to: GMSCameraPosition(target: CLLocationCoordinate2D(latitude: coordinate.latitude - (coordinate.latitude * 0.00006), longitude: coordinate.longitude), zoom: 16))
        
        //Align map to North Heading
        mapView.animate(toBearing: 0)
        
        guard let myloc = mapView.myLocation else { return }
        //drawPath(mapView: mapView, from: myloc.coordinate, to: coordinate)
        
        PathManager.shared.drawPath(mapView: mapView, from: myloc.coordinate, to: coordinate)
    }
}
