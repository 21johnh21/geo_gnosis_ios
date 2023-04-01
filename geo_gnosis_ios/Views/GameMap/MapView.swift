//
//  GameMap.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/12/23.
//

import SwiftUI
import MapKit

struct MapView: View, Equatable{
    
    var coordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()
    var pinLocations: [PinLocation]

    var body: some View {
        Map(coordinateRegion: $region,
            interactionModes: MapInteractionModes.pan,
            annotationItems: pinLocations
        ){
            pinLocation in
                MapAnnotation(coordinate: pinLocation.coordinate) {
                    //Image(systemName: "mappin").font(.system(size: 25, weight: .bold)).foregroundColor(Color(.red))
                    Image("customMapPin")
                }
        }
        .onAppear {
            //MKMapView.appearance().mapType = .satellite //this works but only on the first round
            setRegion(coordinate)
        }
    }

    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}

func == (lhs: MapView, rhs: MapView) -> Bool {
    lhs.coordinate.latitude == rhs.coordinate.latitude
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
//    }
//}
