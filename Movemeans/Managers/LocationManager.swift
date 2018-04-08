//
//  LocationManager.swift
//  Movemeans
//
//  Created by Aaqib Hussain on 7/4/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    func didReceiveLocation(lat: Double, lng: Double)
}


class LocationManager: NSObject {
    
    //MARK: Vars
    //CoreLocationManager from CoreLocation
    let locationManager = CLLocationManager()
    
    weak var delegate: LocationManagerDelegate?
    
    //Singleton
    static private var singleton: LocationManager?
    class var shared: LocationManager {
        guard let sharedInstance = singleton else {
            singleton = LocationManager()
            return singleton!
        }
        return sharedInstance
    }
    
    //initializer
    override init() {
        super.init()
        setupLocationManager()
    }
    
    //MARK: Setup the LocationManager
    private func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.distanceFilter = 100
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
    }
    
    //MARK: Stop Updating Location
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
}
extension LocationManager: CLLocationManagerDelegate {
    
    //MARK: CLLocation Manager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last!
        delegate?.didReceiveLocation(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
    }
    
    
}
