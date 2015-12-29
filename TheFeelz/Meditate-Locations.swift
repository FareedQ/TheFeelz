//
//  Meditate-Location.swift
//  TheFeelz
//
//  Created by FareedQ on 2015-12-28.
//  Copyright © 2015 FareedQ. All rights reserved.
//

import CoreLocation
import MapKit

extension MeditateVC: CLLocationManagerDelegate {
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let usersLocation = locationManager.location else {return}
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(usersLocation.coordinate, zoomRadius, zoomRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
