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
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(CustomColor.primary)
                    .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)

                VStack(spacing: 16){
                    HStack(spacing: 8) {
                        Image(systemName: "trophy.fill")
                            .font(.system(size: Const.fontSizeTitleLrg - 4))
                            .foregroundColor(.yellow)
                        Text("Game Over!")
                            .font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg))
                            .fontWeight(.bold)
                    }
                    .padding(.top, 16)

                    // Final Score with prominence
                    VStack(spacing: 8) {
                        HStack(spacing: 6) {
                            Image(systemName: "star.fill")
                                .font(.system(size: Const.fontSizeNormStd))
                                .foregroundColor(.yellow)
                            Text("Final Score")
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                        }
                        Text("\(finalScore)")
                            .font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg + 8))
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    .padding(.bottom, 16)
                }
            }

            // Map Section
            MapView2(pinLocations: initPinLocations(), centerLat: $centerLat, centerLng: $centerLng)
                .frame(height: 250)
                .cornerRadius(8)
                .padding(.top, 12)
                .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 2)

            // Action Buttons
            HStack(spacing: 16){
                // Play Again - Primary Action
                Button(action: {
                    timerGlobal.showSetUp = false
                    PlayDefaultFeedback().play()
                    coordinator.show(Start.self)
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "play.fill")
                            .font(.system(size: Const.fontSizeNormStd))
                        Text("Play Again")
                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(CustomColor.secondary)
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 3)
                    )
                }

                // Return to Menu - Secondary Action
                Button(action: {
                    PlayDefaultFeedback().play()
                    coordinator.popToRoot()
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "house.fill")
                            .font(.system(size: Const.fontSizeNormStd))
                        Text("Menu")
                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(CustomColor.primary)
                            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                    )
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)

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
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .padding(.top, 16)
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
