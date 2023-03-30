//
//  MapViewVM.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/16/23.
//

import Foundation
import MapKit
import CoreLocation 

extension MapView{
    @MainActor class MapViewVM: ObservableObject{
        
        var roundInfo: RoundInfo = RoundInfo()
        
        @Published private var region = MKCoordinateRegion()
        
        private func setRegion(_ coordinate: CLLocationCoordinate2D) {
            region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        }
        func InitPinLocations() -> Array <PinLocation>{
            var pinLocations = [PinLocation]()
            var pinLocation = PinLocation(name: "", coordinate: CLLocationCoordinate2D(
                latitude: 0.0, longitude: 0.0))
            
            for i in 0...roundInfo.roundNumber{
                pinLocation.coordinate = CLLocationCoordinate2D(
                    latitude: roundInfo.locations[i].lat, longitude: roundInfo.locations[i].lng)
                pinLocation.name=""
                pinLocations.append(pinLocation)
            }
            return pinLocations
        }
        
    }
}
