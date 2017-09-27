//
//  LocationController.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/26/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import Foundation
import CoreLocation

typealias LocationCallback = (CLLocation) -> ()

class LocationController:NSObject {
    
    var locationCallback:LocationCallback?
    
    let locationManager = CLLocationManager()
    
    init(callback:@escaping LocationCallback) {
        super.init()
        
        locationCallback = callback
        locationManager.delegate = self

        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
}

extension LocationController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let callback = locationCallback else {
            return
        }
        
        callback(locations[0])
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location error: "+error.localizedDescription)
    }
}
