//
//  MapView2.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/29/23.
//

import SwiftUI
import MapKit

struct MapView2: View {
    
    var pinLocations: [PinLocation]
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15))
    
    var body: some View{
        Map(coordinateRegion: $mapRegion, annotationItems: pinLocations) { pinLocation in
                MapAnnotation(coordinate: pinLocation.coordinate) {

                    Circle()
                        .stroke(.red, lineWidth: 3)
                        .frame(width: 44, height: 44)
                        .onTapGesture {
                            let url = URL(string: "maps://?ll=\(pinLocation.coordinate.latitude),\(pinLocation.coordinate.longitude)&z=10.0")
                            //in this url ll = the coordinates of map center, z = the zoom level (smaller value is more zoomed)
                            if (UIApplication.shared.canOpenURL(url!)) {
                                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                            }
                        }
                }
            }
    }
    
}

//struct PinLocation: Identifiable {
//    let id = UUID()
//    let name: String
//    let coordinate: CLLocationCoordinate2D
//}

//struct MapView_Previews2: PreviewProvider {
//    static var previews: some View {
//        MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
//    }
//    
//}
