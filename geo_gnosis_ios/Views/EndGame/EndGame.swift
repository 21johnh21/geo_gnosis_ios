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
    @EnvironmentObject var gameInfo: GameInfo
    @EnvironmentObject var audioPlayer: AudioPlayer
    @EnvironmentObject var timerGlobal: TimerGlobal
    
    @State var finalScore: Int = 0
    
    @State var centerLat: Double = 0
    @State var centerLng: Double = 0

    var body: some View {
        VStack {
            VStack{
            Text("Game Over!").font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg)).padding()
            HStack {
                Text("Final Score: ").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)).padding(.leading)
                Spacer()
                Text("\(finalScore)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)).padding(.trailing)
            }
            
            }.background(){
                RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
            }
            
            MapView2(pinLocations: initPinLocations(), centerLat: $centerLat, centerLng: $centerLng)
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    Text("Play Again").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                }.onTapGesture {
                    timerGlobal.showSetUp = false
                    PlayDefaultFeedback().play()
                    coordinator.show(Start.self)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    Text("Return to Menu").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                }.onTapGesture {
                    PlayDefaultFeedback().play()
                    coordinator.popToRoot()
                }
            }
            ScrollView{
                ForEach(roundInfo.roundNumbers.indices) { index in
                    EndGameCard(location: roundInfo.locations[index], roundNumber: roundInfo.roundNumbers[index], time: roundInfo.times[index], answer: roundInfo.answers[index])
                }
            }
        }.navigationBarBackButtonHidden(true)
        .background(alignment: .center){BackgroundView()}
        .onAppear(){
            audioPlayer.stopBackground()
            finalScore = calcFinalScore()
        }
    }
    
    func initPinLocations() -> Array <PinLocation>{
        var pinLocations = [PinLocation]()
        var pinLocation = PinLocation(name: "", coordinate: CLLocationCoordinate2D(
            latitude: 0.0, longitude: 0.0))

        // Guard against accessing beyond available locations
        let maxIndex = min(roundInfo.roundNumber, roundInfo.locations.count - 1)
        guard maxIndex >= 0, !roundInfo.locations.isEmpty else {
            return pinLocations
        }

        for i in 0...maxIndex{
            pinLocation.coordinate = CLLocationCoordinate2D(
                latitude: roundInfo.locations[i].lat, longitude: roundInfo.locations[i].lng)
            pinLocation.name=""
            pinLocations.append(pinLocation)
        }
        return pinLocations
    }
    func calcFinalScore() -> Int{
        var finalScore: Int = 0
        let maxIndex = min(roundInfo.roundNumber, roundInfo.times.count - 1)

        guard maxIndex >= 0 else {
            return 0
        }

        for i in 0...maxIndex{
            if(roundInfo.times[i] != -1){
                finalScore += roundInfo.times[i]
            }
        }
        return finalScore
    }
}

//struct EndGame_Previews: PreviewProvider {
//    static var previews: some View {
//        EndGame()
//    }
//}
