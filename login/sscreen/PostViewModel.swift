

import Foundation
import os.log
import UIKit
import CoreLocation

class PostViewModel: NSObject, ObservableObject {
    
    @Published var image: UIImage?
    @Published var caption = ""
    
    
    private var authorizationStatus: CLAuthorizationStatus
    private var lastSeenLocation: CLLocation?
    private let locationManager: CLLocationManager
    
    
    
    // MARK: Intents
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    
    // MARK: Queries
    
    
    
    // MARK: CLLocationManagerDelegate
    extension PostViewModel: CLLocationManagerDelegate {
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            authorizationStatus = manager.authorizationStatus
        }
}
