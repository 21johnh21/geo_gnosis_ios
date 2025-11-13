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

    @AppStorage("sateliteMapOn") var sateliteMapOn: Bool = true

    @EnvironmentObject var timerGlobal: TimerGlobal
    @EnvironmentObject var roundInfo : RoundInfo

    var body: some View {
        if #available(iOS 17.0, *) {
            Map(coordinateRegion: $region,
                interactionModes: MapInteractionModes.pan,
                annotationItems: pinLocations
            ){
                pinLocation in
                    MapAnnotation(coordinate: pinLocation.coordinate) {
                        Image("customMapPin")
                    }
            }
            .mapStyle(sateliteMapOn ? .imagery : .standard)
            .onAppear {
                setRegion(coordinate)
                penaltyDistance = Const.PenaltyDistance
            }
            .onChange(of: region.center.latitude) { value in
                if(getDistance() >= penaltyDistance){
                    penaltyDistance += Const.PenaltyDistance
                    timerGlobal.penalty.toggle()
                    print("Out of Bounds! \(penaltyDistance) penalty \(timerGlobal.penalty) centerLat: \(pinLocations[roundInfo.roundNumber].coordinate.latitude) centerLng: \(pinLocations[roundInfo.roundNumber].coordinate.longitude) currentLat: \(region.center.latitude) currentLng: \(region.center.longitude)")
                }
            }
        } else {
            // Fallback for iOS 16 and earlier - standard map only
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
                if(getDistance() >= penaltyDistance){
                    penaltyDistance += Const.PenaltyDistance
                    timerGlobal.penalty.toggle()
                    print("Out of Bounds! \(penaltyDistance) penalty \(timerGlobal.penalty) centerLat: \(pinLocations[roundInfo.roundNumber].coordinate.latitude) centerLng: \(pinLocations[roundInfo.roundNumber].coordinate.longitude) currentLat: \(region.center.latitude) currentLng: \(region.center.longitude)")
                }
            }
        }
    }

    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
    func getDistance() -> Double{
        // Guard against invalid round number or empty pinLocations
        guard roundInfo.roundNumber < pinLocations.count, !pinLocations.isEmpty else {
            print("Error: Invalid round number or empty pinLocations")
            return 0.0
        }

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
