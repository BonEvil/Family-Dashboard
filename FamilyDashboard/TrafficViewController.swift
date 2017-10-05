//
//  TrafficViewController.swift
//  FamilyDashboard
//
//  Created by Daniel Person on 9/26/17.
//  Copyright © 2017 Daniel Person. All rights reserved.
//

import UIKit
import GoogleMaps

class TrafficViewController: UIViewController {
    
    var closeButton: UIButton!
    
    var location:CLLocation?
    
    override func loadView() {
        
        if let location = self.location {
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 14)
            let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
            mapView.isTrafficEnabled = true
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            marker.map = mapView
            
            view = mapView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        closeButton = UIButton(type: .system)
        closeButton.frame = CGRect(x: 24.0, y: 24.0, width: 32.0, height: 32.0)
        closeButton.tintColor = UIColor(red: 0, green: 170/255.0, blue: 1, alpha: 1)
        closeButton.setImage(UIImage(named: "Close"), for: .normal)
        closeButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(closeButton)
    }
    
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case closeButton:self.dismiss(animated: true, completion: nil)
        default:break
        }
    }
}
