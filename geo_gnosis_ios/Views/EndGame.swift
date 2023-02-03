//
//  EndGame.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/23/23.
//

import SwiftUI
import MapKit



struct EndGame: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var roundInfo : RoundInfo
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
                
                ForEach(roundInfo.roundNumbers.indices) { index in
                    EndGameCard(location: roundInfo.locations[index], roundNumber: roundInfo.roundNumbers[index], time: roundInfo.times[index], answer: roundInfo.answers[index])
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    func InitPinLocations() -> Array <PinLocation>{
        var pinLocations = [PinLocation]()
        var pinLocation = PinLocation(name: "", coordinate: CLLocationCoordinate2D(
            latitude: 0.0, longitude: 0.0))
        
        for i in 0...roundInfo.roundNumber{
            //var pinLocation: PinLocation
            pinLocation.coordinate = CLLocationCoordinate2D(
                latitude: roundInfo.locations[i].lat, longitude: roundInfo.locations[i].lng)
            pinLocation.name=""
            pinLocations.append(pinLocation)
        }
        return pinLocations
    }
    func CalcFinalScore() -> Int{
        var finalScore: Int = 0
        for i in 0...roundInfo.roundNumber{
            finalScore += roundInfo.times[i]
        }
        return finalScore
    }
}

struct EndGame_Previews: PreviewProvider {
    static var previews: some View {
        EndGame()
    }
}
