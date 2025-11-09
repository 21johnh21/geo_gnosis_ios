//
//  MapView2.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/29/23.
//

import SwiftUI
import MapKit

struct MapView2: View {
    
    @EnvironmentObject var roundInfo : RoundInfo
    @EnvironmentObject var gameInfo: GameInfo
    
    var pinLocations: [PinLocation]
    @Binding var centerLat: Double
    @Binding var centerLng: Double
    
    @State private var mapRegion = MKCoordinateRegion()
    
    var body: some View{
        Map(coordinateRegion: $mapRegion, annotationItems: pinLocations) { pinLocation in
                MapAnnotation(coordinate: pinLocation.coordinate) {

                    Image("customMapPin")
                        .onTapGesture {
                            let url = URL(string: "maps://?ll=\(pinLocation.coordinate.latitude),\(pinLocation.coordinate.longitude)&z=10.0")
                            //in this url ll = the coordinates of map center, z = the zoom level (smaller value is more zoomed)
                            if (UIApplication.shared.canOpenURL(url!)) {
                                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                            }
                        }
                }
        }
        .onAppear(){
            if(gameInfo.regionMode == Const.modeRegCountryText){
                centerLat = roundInfo.locations[0].lat
                centerLng = roundInfo.locations[0].lng
            }else{
                findCenterCoordinate()
            }
            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: centerLat, longitude: centerLng), span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15))
            print("End Game \(centerLat), \(centerLng)")
        }
        .onChange(of: centerLat) { newLat in
            // Animate to new location when centerLat changes
            withAnimation {
                mapRegion.center = CLLocationCoordinate2D(latitude: newLat, longitude: centerLng)
            }
        }
        .onChange(of: centerLng) { newLng in
            // Animate to new location when centerLng changes
            withAnimation {
                mapRegion.center = CLLocationCoordinate2D(latitude: centerLat, longitude: newLng)
            }
        }
    }
    func findCenterCoordinate(){
        var i: Int = 0
        
        var radianLat: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]
        var radianLng: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]
        
        var cartesianX: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]
        var cartesianY: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]
        var cartesianZ: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]

        var totalWeight: Int = 5 //one for each coord
        var weightedX: Double = 0
        var weightedY: Double = 0
        var weightedZ: Double = 0
        
        var centerRadianLat: Double = 0
        var centerRadianLng: Double = 0
        var centerHyp: Double = 0
        
        for coordinate in roundInfo.locations{
            radianLat[i] = coordinate.lat * Double.pi / 180
            radianLng[i] = coordinate.lng * Double.pi / 180
            cartesianX[i] = cos(radianLat[i]) * cos(radianLng[i])
            cartesianY[i] = cos(radianLat[i]) * sin(radianLng[i])
            cartesianZ[i] = sin(radianLat[i])
            
            i += 1
        }
        
        for j in 0 ... 4 {
            weightedX += weightedX + cartesianX[j]
            weightedY += weightedY + cartesianY[j]
            weightedZ += weightedZ + cartesianZ[j]
        }
        weightedX = weightedX / Double(totalWeight)
        weightedY = weightedY / Double(totalWeight)
        weightedZ = weightedZ / Double(totalWeight)
        
        centerRadianLng = atan2(weightedY, weightedX)
        centerHyp = sqrt(weightedX * weightedX + weightedY * weightedY)
        centerRadianLat = atan2(weightedZ, centerHyp)
        
        centerLat = centerRadianLat * 180 / Double.pi
        centerLng = centerRadianLng * 180 / Double.pi
        print("Center Coordinates \(centerLat), \(centerLng)")
        
    }
    
}

//struct MapView_Previews2: PreviewProvider {
//    static var previews: some View {
//        MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
//    }
//    
//}
