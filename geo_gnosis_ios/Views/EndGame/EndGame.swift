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
        VStack(spacing: 0) {
            // Header Section
            VStack(spacing: 12){
                Text("Game Over!")
                    .font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg))
                    .fontWeight(.bold)
                    .padding(.top, 12)

                HStack {
                    Text("Final Score")
                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(finalScore)")
                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg))
                        .fontWeight(.bold)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            }
            .background(){
                RoundedRectangle(cornerRadius: 5)
                    .fill(CustomColor.primary)
            }
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

            // Map Section
            MapView2(pinLocations: initPinLocations(), centerLat: $centerLat, centerLng: $centerLng)
                .frame(height: 250)
                .cornerRadius(5)
                .padding(.top, 8)
                .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 2)

            // Action Buttons
            HStack(spacing: 12){
                Button(action: {
                    timerGlobal.showSetUp = false
                    PlayDefaultFeedback().play()
                    coordinator.show(Start.self)
                }) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(CustomColor.primary)
                            .frame(height: 44)
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                        Text("Play Again")
                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                }

                Button(action: {
                    PlayDefaultFeedback().play()
                    coordinator.popToRoot()
                }) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(CustomColor.primary)
                            .frame(height: 44)
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                        Text("Return to Menu")
                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding(.top, 12)
            .padding(.horizontal, 8)

            // Scrollable Cards
            ScrollView{
                VStack(spacing: 20) {
                    ForEach(roundInfo.roundNumbers.indices) { index in
                        EndGameCard(location: roundInfo.locations[index], roundNumber: roundInfo.roundNumbers[index], time: roundInfo.times[index], answer: roundInfo.answers[index])
                            .onTapGesture {
                                // Center map on the tapped location
                                centerLat = roundInfo.locations[index].lat
                                centerLng = roundInfo.locations[index].lng
                                PlayDefaultFeedback().play()
                            }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
            }
        }
        .navigationBarBackButtonHidden(true)
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
