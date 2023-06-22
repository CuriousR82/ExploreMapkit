//
//  MapController.swift
//  ExploreMapkit
//
//  Created by Rosa Jeon on 2023-06-19.
//

import MapKit
import SwiftUI
//import LocationManager

class MapController: ObservableObject {
    var searchTerm = ""
    @Published var isBusinessViewShowing = false
    @Published private(set) var business = [Business]()
    @Published private(set) var selectedBusiness: Business?
    @Published private(set) var actions = [Action]()
    @StateObject var manager = LocationManager()
    
    // first method
//    var region = Map(coordinateRegion: $manager.region)
    
    // second method
//    var region: Map<_DefaultMapContent>
//
//    init() {
//        region = Map(coordinateRegion: $manager.region)
//    }
    
    // third method
    lazy var region: Map<_DefaultMapContent> = {
        return Map(coordinateRegion: self.$manager.region)
    }()

    var selectBusinessName: String {
        guard let selectBusiness = selectedBusiness else { return "" }
        return selectBusiness.name
    }
    
    var selectBusinessPlacemark: String {
        guard let selectBusiness = selectedBusiness else { return "??" }
        return selectBusiness.placemark.title ?? "??"
    }
}

