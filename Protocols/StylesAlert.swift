//
//  StylesAlert.swift
//  GooGooMaps
//
//  Created by Usman Nazir on 02/08/2019.
//  Copyright © 2019 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

protocol ShowsStylesAlert { }

extension ShowsStylesAlert {
    
    
    
    func OpenAlertViewController(){
        
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
        
        
    }
}
