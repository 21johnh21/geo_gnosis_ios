//
//  RootView.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/25/23.
//

import Foundation
import SwiftUI

struct RootView: View {
    
    @AppStorage("lastMultiChoice") var lastMultiChoice: Bool = true
    @AppStorage("lastRegionMode") var lastRegionMode: String = ""
    @AppStorage("lastRegion") var lastRegion: String = ""
    @AppStorage("lastDifficulty") var lastDifficulty: String = ""
    @AppStorage("sateliteMapOn") var sateliteMapOn: Bool = true

    @EnvironmentObject var gameInfo: GameInfo
    @StateObject private var coordinator = Coordinator()
    @EnvironmentObject var timerGlobal: TimerGlobal
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ScrollView{
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 80)
                    Text("Geo Gnosis").font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg)).padding(.top)
                }
                Image(Const.picLogo).resizable().frame(width: 255, height: 255).clipShape(Circle()).padding()
                //MARK: Play Again Button ---------------------------------
                if(isStorageSet()){
                    ZStack{
                        RoundedRectangle(cornerRadius: 5, style: .continuous).fill(CustomColor.primary)
                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                        VStack(spacing: 12){
                            Text("\(Image(systemName: "play.fill")) Play Again")
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg))

                            // Game settings in a compact grid
                            VStack(spacing: 6) {
                                HStack(spacing: 16) {
                                    // Game Mode
                                    HStack(spacing: 4) {
                                        let gameModeIcon = lastMultiChoice ? "checklist" : "keyboard"
                                        let lastMultiChoiceText = lastMultiChoice ? Const.modeMultiChoiceText : Const.modeFillBlankText
                                        Image(systemName: gameModeIcon)
                                            .font(.system(size: Const.fontSizeNormStd - 3))
                                        Text(lastMultiChoiceText)
                                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                    }
                                    .foregroundColor(.gray)

                                    // Difficulty
                                    HStack(spacing: 4) {
                                        let difficultyIcon = lastDifficulty == Const.modeDiffEasyText ? "star" : (lastDifficulty == Const.modeDiffMedText ? "star.leadinghalf.filled" : "star.fill")
                                        Image(systemName: difficultyIcon)
                                            .font(.system(size: Const.fontSizeNormStd - 3))
                                        Text(lastDifficulty)
                                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                    }
                                    .foregroundColor(.gray)
                                }

                                HStack(spacing: 16) {
                                    // Region Mode & Region
                                    HStack(spacing: 4) {
                                        let regionIcon = lastRegionMode == Const.modeRegCountryText ? "globe" : (lastRegionMode == Const.modeRegRegionText ? "building.2" : "building.2.fill")
                                        Image(systemName: regionIcon)
                                            .font(.system(size: Const.fontSizeNormStd - 3))
                                        if lastRegionMode == Const.modeRegCountryText {
                                            Text(lastRegionMode)
                                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                        } else {
                                            let lastRegionText = lastRegion == Const.modeRegCountryText ? "World" : lastRegion
                                            Text("\(lastRegionMode) • \(lastRegionText)")
                                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                        }
                                    }
                                    .foregroundColor(.gray)

                                    // Map Type
                                    HStack(spacing: 4) {
                                        let mapViewIcon = sateliteMapOn ? "globe.americas.fill" : "map"
                                        Image(systemName: mapViewIcon)
                                            .font(.system(size: Const.fontSizeNormStd - 3))
                                        Text(sateliteMapOn ? "Satellite" : "Standard")
                                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                    }
                                    .foregroundColor(.gray)
                                }
                            }
                        }.padding()
                    }.onTapGesture {
                        PlayDefaultFeedback().play()
                        gameInfo.multiChoice = lastMultiChoice
                        gameInfo.regionMode = lastRegionMode
                        gameInfo.region = lastRegion
                        gameInfo.difficulty = lastDifficulty
                        timerGlobal.showSetUp = false
                        coordinator.show(Start.self)
                    }
                }
                //MARK: Set Up Game ----------------------------
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(CustomColor.primary).shadow(color: .black, radius: 3, x: 2, y: 2)
                    VStack{
                        Text("\(Image(systemName: "gear")) Set Up Game").font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg))
                    }.padding()
                }.onTapGesture {
                    timerGlobal.showSetUp = true
                    coordinator.show(Start.self)
                }
                //MARK: Other buttons ------------------------------------------
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).shadow(color: .black, radius: 3, x: 2, y: 2)
                        Text("Settings").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    }.onTapGesture {
                        PlayDefaultFeedback().play()
                        coordinator.show(Settings.self)
                    }
                }
            }
            .navigationDestination(for: String.self) { id in
                if id == String(describing: Start.self) {
                    Start()
                } else if id == String(describing: GameMap.self) {
                    GameMap()
                }
                else if id == String(describing: EndGame.self){
                    EndGame()
                }
                else if id == String(describing: Settings.self){
                    Settings()
                }
            }
            .background(alignment: .center){BackgroundView()}
        }
        .environmentObject(coordinator)
    }
    func isStorageSet() -> Bool{
        if(lastRegionMode == "" || lastRegion == "" || lastDifficulty == ""){
            return false
        }else{
            return true
        }
    }
}
