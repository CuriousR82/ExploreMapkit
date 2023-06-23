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
    lazy var region: MKCoordinateRegion = {
//        return Map(coordinateRegion: self.$manager.region)
        return manager.region
    }()

    var selectBusinessName: String {
        guard let selectBusiness = selectedBusiness else { return "" }
        return selectBusiness.name
    }
    
    var selectBusinessPlacemark: String {
        guard let selectBusiness = selectedBusiness else { return "??" }
        return selectBusiness.placemark.title ?? "??"
    }
    
    func search() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTerm
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else { return }
            
            DispatchQueue.main.async {
                self.business = response.mapItems.map { item in
                    Business(name: item.name ?? "", placemark: item.placemark, coordinate: item.placemark.coordinate, phoneNumber: item.phoneNumber ?? "", website: item.url)
                }
            }
        }
        // make a function that createActions()
        createActions()
    }
    
    func openMap(coordinate: CLLocationCoordinate2D) {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.openInMaps()
    }
    
    func setSelectedBusiness(for business: Business) {
        selectedBusiness = business
        isBusinessViewShowing.toggle()
    }
    
    func createActions() {
        actions = [
            Action(title: "Directions", image: "car.fill") { [weak self] in
                guard let self = self else { return }
                self.openMap(coordinate: self.selectedBusiness!.coordinate)
            },
            Action(title: "Call", image: "phone.fill") { [weak self] in
                guard let self = self else { return }
                guard let phoneNumber = self.selectedBusiness?.phoneNumber else { return }
                guard let url = URL(string: self.convertPhoneNumberFormat(phoneNumber: phoneNumber)) else { return }
                UIApplication.shared.open(url)
            },
            Action(title: "Website", image: "safari.fill") { [weak self] in
                guard let self = self else { return }
                guard let website = self.selectedBusiness?.website else { return }
                UIApplication.shared.open(website)
            },
        ]
    }
    
    func convertPhoneNumberFormat(phoneNumber: String) -> String {
        let strippedPhoneNumber = phoneNumber
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        
        return "tel//\(strippedPhoneNumber)"
    }
}

