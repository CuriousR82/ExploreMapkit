//
//  LocationManager.swift
//  ExploreMapkit
//
//  Created by Rosa Jeon on 2023-06-22.
//

// LocationManager.swift

//import MapKit
//import CoreLocation
//
//class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
//    @Published var region = MKCoordinateRegion()
//    private let manager = CLLocationManager()
//
//    override init() {
//        super.init()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//
//    func startUpdatingLocation() {
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1600, longitudinalMeters: 1600)
//        }
//    }
//}
