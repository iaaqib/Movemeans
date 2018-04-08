//
//  ViewController.swift
//  Movemeans
//
//  Created by Aaqib Hussain on 7/4/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import UIKit
import CoreMotion



class ViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var infoLabel: UILabel!
    
    //MARK: Vars
    var travelMeans = ""
    var coordinates: (lat: Double, lng: Double) = (0.0, 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.shared.delegate = self
        MotionManager.shared.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

extension ViewController: LocationManagerDelegate {
    
    //MARK: Location Manager Delegate
    func didReceiveLocation(lat: Double, lng: Double) {
        
        coordinates = (lat, lng)
        let info = "Latitude: \(lat) \nLongitude: \(lng) \nMode: \(travelMeans)"
        self.infoLabel.text = info
        debugPrint(info)
    }
    
}
extension ViewController: MotionManagerDelegate {
    
    //MARK: Motion Manager Delegate
    func didMotionMeansChanged(means: String) {
        
        travelMeans = means
        let info = "Latitude: \(coordinates.lat) \nLongitude: \(coordinates.lng) \nMode: \(means)"
        self.infoLabel.text = info
        debugPrint(info)
    }
}
