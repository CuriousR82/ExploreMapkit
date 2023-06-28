//
//  MapView.swift
//  ExploreMapkit
//
//  Created by Rosa Jeon on 2023-06-23.
//

// MapView.swift

import SwiftUI
import MapKit
//import CoreLocation

struct MapView: View {
    @ObservedObject var mapController: MapController

    var body: some View {
        Map(coordinateRegion: $mapController.region, annotationItems: mapController.businesses) { business in
            
            MapAnnotation(coordinate: business.coordinate) {
                Image(systemName: "mappin.and.elipse")
                    .font(.title)
                    .foregroundColor(.pink)
                    .onTapGesture {
                        mapController.setSelectedBusiness(for: business)
                    }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $mapController.isBusinessViewShowing) {
            BusinessView(mapController: mapController)
                .presentationDetents([.fraction(0.27), .large])
        }
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mapController: MapController())
    }
}
