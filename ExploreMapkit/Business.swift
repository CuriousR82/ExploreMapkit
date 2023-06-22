//
//  Business.swift
//  ExploreMapkit
//
//  Created by Rosa Jeon on 2023-06-19.
//

import Foundation
import MapKit

struct Business: Identifiable {
    let id = UUID()
    let name: String
    let placemark: MKPlacemark
    let coordinate: CLLocationCoordinate2D
    let phoneNumber: String
    let website: URL?
}
