//
//  MotionManager.swift
//  Movemeans
//
//  Created by Aaqib Hussain on 7/4/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import Foundation
import CoreMotion

protocol MotionManagerDelegate: class {
    func didMotionMeansChanged(means: String)
}

class MotionManager: NSObject {
    
    //MARK: Vars
    //Motion Manager from CoreMotion
    let motionManager = CMMotionActivityManager()
    
    weak var delegate: MotionManagerDelegate?
    
    //Singleton
    static private var singleton: MotionManager?
    class var shared: MotionManager {
        guard let sharedInstance = singleton else {
            singleton = MotionManager()
            return singleton!
        }
        return sharedInstance
    }
    
    //MARK: Enum for type of motion
    private enum MotionMeans: String {
        case stationary = "Stationary"
        case cycling = "Cycling"
        case automotive = "Driving"
        case walking = "Walking"
        case running = "Running"
        case cycleStationary = "On a Cycle, Stationary"
        case automotiveStationary = "In a Car, Stationary"
        case unknown = "Unknown"
    }
    
    //initializer
    override init() {
        super.init()
        setupMotionManager()
        
    }
    
    //MARK: Setup the MotionManager
    private func setupMotionManager() {
        
        motionManager.startActivityUpdates(to: .main) { [weak self] (activity) in
            guard let activity = activity else {return}
            var motionMeans: MotionMeans = .unknown
            
            if  activity.stationary {
                motionMeans = .stationary
            } else if activity.walking {
                motionMeans = .walking
            } else if activity.running {
                motionMeans = .running
            } else if activity.cycling {
                motionMeans = .cycling
            } else if activity.automotive {
                motionMeans = .automotive
            } else if activity.cycling && activity.stationary {
                motionMeans = .cycleStationary
            } else if activity.automotive && activity.stationary {
                motionMeans = .automotiveStationary
            }
            self?.delegate?.didMotionMeansChanged(means: motionMeans.rawValue)
        }
        
    }
    
    //MARK: Stop Updating Motion
    func stopUpdatingMotion() {
        motionManager.stopActivityUpdates()
    }
}

