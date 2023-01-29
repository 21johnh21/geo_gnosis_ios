//
//  EndGame.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/23/23.
//

import SwiftUI
import MapKit

struct EndGame: View {
    
    let data = LocationData().locations
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var gameInfo : GameInfo
    var roundNumber: Int = 0
    
    var body: some View {
        VStack {
            Text("Game Over!").padding()
            HStack {
                Text("Final Score: ").padding(.leading)
                Spacer()
                Text("0:00").padding(.trailing)
            }
            HStack{
                Button {
                    coordinator.show(Start.self)
                } label: {
                    Text("Play Again")
                }.padding(.leading)
                Spacer()
                Button {
                    coordinator.popToRoot()
                } label: {
                    Text("Return to Menu")
                }.padding(.trailing)
            }
//            MapView(coordinate:
//                        CLLocationCoordinate2D(
//                            latitude: data[0].lat,
//                            longitude: data[0].lng)
//            ).frame(height: 300)
            MapView2(pinLocations: InitPinLocations())
           
            ScrollView{
                ForEach(gameInfo.locations) { location in
                    EndGameCard(location: location)
                }
            }
        }
    }
    
    func InitPinLocations() -> Array <PinLocation>{
        //@EnvironmentObject var gameInfo : GameInfo
        var pinLocations = [PinLocation]()
        var pinLocation = PinLocation(name: "", coordinate: CLLocationCoordinate2D(
            latitude: 0.0, longitude: 0.0))
        
        for i in 0...gameInfo.roundNumber{
            //var pinLocation: PinLocation
            pinLocation.coordinate = CLLocationCoordinate2D(
                latitude: gameInfo.locations[i].lat, longitude: gameInfo.locations[i].lng)
            pinLocation.name=""
            pinLocations.append(pinLocation)
        }
        return pinLocations
    }
}

func IncrementRoundNumber(count: Int) -> Int{
    return count + 1
}

//func InitPinLocations() -> Array <PinLocation>{
//    @EnvironmentObject var gameInfo : GameInfo
//    var pinLocations = [PinLocation]()
//    var pinLocation = PinLocation(name: "", coordinate: CLLocationCoordinate2D(
//        latitude: 0.0, longitude: 0.0))
//
//    for i in 0...gameInfo.roundNumber{
//        //var pinLocation: PinLocation
//        pinLocation.coordinate = CLLocationCoordinate2D(
//            latitude: gameInfo.locations[i].lat, longitude: gameInfo.locations[i].lng)
//        pinLocation.name=""
//        pinLocations.append(pinLocation)
//    }
//    return pinLocations
//}

struct EndGame_Previews: PreviewProvider {
    static var previews: some View {
        EndGame()
    }
}
