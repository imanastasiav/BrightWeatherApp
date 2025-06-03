//
//  LocationManager.swift
//  BrightWeatherApp
//
//  Created by Анастасия on 03.06.2025.
//

import CoreLocation
import Foundation
import UIKit

    final class LocationManager: NSObject, CLLocationManagerDelegate {
        
        private let manager = CLLocationManager()
        
        static let shared = LocationManager()
        
        private var locationFetchCompletion: ((CLLocation) -> Void)?
        
        private var location: CLLocation? {
            didSet {
                guard let location else {
                    return
                }
                locationFetchCompletion?(location)
            }
        }
        
        public func getCurrentLocation(completion: @escaping (CLLocation) -> Void) {
            
            self.locationFetchCompletion = completion
            
            manager.requestWhenInUseAuthorization()
            manager.delegate = self
            manager.startUpdatingLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.first else {
                return
            }
            self.location = location
            manager.startUpdatingLocation()
        }
    }

