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
                Text("\(CalcFinalScore())").padding(.trailing)
            }
            

            MapView2(pinLocations: InitPinLocations())
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green).frame(height: 30)
                    Text("Play Again")
                }.onTapGesture {
                    coordinator.show(Start.self)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green).frame(height: 30)
                    Text("Return to Menu")
                }.onTapGesture {
                    coordinator.popToRoot()
                }
            }
            
           
            ScrollView{
                
                ForEach(gameInfo.roundNumbers.indices) { index in
                    EndGameCard(location: gameInfo.locations[index], roundNumber: gameInfo.roundNumbers[index], time: gameInfo.times[index], answer: gameInfo.answers[index])
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    func InitPinLocations() -> Array <PinLocation>{
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
    func CalcFinalScore() -> Int{
        var finalScore: Int = 0
        for i in 0...gameInfo.roundNumber{
            finalScore += gameInfo.times[i]
        }
        return finalScore
    }
}

//func IncrementRoundNumber(count: Int) -> Int{
//    return count + 1
//}

struct EndGame_Previews: PreviewProvider {
    static var previews: some View {
        EndGame()
    }
}
