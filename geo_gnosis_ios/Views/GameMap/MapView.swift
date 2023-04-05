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
    var pinLocations: [PinLocation]
    
    @State private var region = MKCoordinateRegion()
    @State private var distanceFromPin: Double = 0
    @State private var penaltyDistance: Double = Const.PenaltyDistance
    
    @EnvironmentObject var timerGlobal: TimerGlobal
    @EnvironmentObject var roundInfo : RoundInfo

    var body: some View {
        Map(coordinateRegion: $region,
            interactionModes: MapInteractionModes.pan,
            annotationItems: pinLocations
        ){
            pinLocation in
                MapAnnotation(coordinate: pinLocation.coordinate) {
                    Image("customMapPin")
                }
        }
        .onAppear {
            setRegion(coordinate)
            penaltyDistance = Const.PenaltyDistance
        }
        .onChange(of: region.center.latitude) { value in
            if(GetDistance() >= penaltyDistance){
                penaltyDistance += Const.PenaltyDistance
                timerGlobal.penalty.toggle()
                print("Out of Bounds! \(penaltyDistance) penalty \(timerGlobal.penalty) centerLat: \(pinLocations[roundInfo.roundNumber].coordinate.latitude) centerLng: \(pinLocations[roundInfo.roundNumber].coordinate.longitude) currentLat: \(region.center.latitude) currentLng: \(region.center.longitude)")
            }
        }
    }

    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
    func GetDistance() -> Double{
        let earthRadius: Double = 6371
        let centerLat = pinLocations[roundInfo.roundNumber].coordinate.latitude
        let centerLng = pinLocations[roundInfo.roundNumber].coordinate.longitude
        let curentLat = region.center.latitude
        let curentLng = region.center.longitude
        
        let z = centerLat * Double.pi/180
        let y = curentLat * Double.pi/180
        
        
        let x = (curentLat - centerLat) * Double.pi/180
        let w = (curentLng - centerLng) * Double.pi/180
        let a = sin(x/2) * sin(x/2) +
        cos(z) * cos(y) * sin(w/2) * sin(w/2)
        
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        let d = earthRadius * c //meters
        
        return d
    }

    static func == (lhs: MapView, rhs: MapView) -> Bool {
        lhs.coordinate.latitude == rhs.coordinate.latitude
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
//    }
//}
