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
                // Header with Settings button
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 80)
                    Text("Geo Gnosis")
                        .font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg))
                        .padding(.top)

                    // Settings button in top-right
                    HStack{
                        Spacer()
                        Button(action: {
                            PlayDefaultFeedback().play()
                            coordinator.show(Settings.self)
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.primary)
                                .padding(.trailing, 20)
                                .padding(.top, 8)
                        }
                    }
                }

                Image(Const.picLogo)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding(.vertical, 20)

                VStack(spacing: 16) {
                    //MARK: Play Again Button ---------------------------------
                    if(isStorageSet()){
                        ZStack{
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(CustomColor.secondary)
                                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 3)
                            VStack(spacing: 12){
                                Text("\(Image(systemName: "play.fill")) Play Again")
                                    .font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg))
                                    .foregroundColor(.primary)

                                // Game settings display
                                GameSettingsDisplay(
                                    multiChoice: lastMultiChoice,
                                    difficulty: lastDifficulty,
                                    regionMode: lastRegionMode,
                                    region: lastRegion,
                                    sateliteMapOn: sateliteMapOn,
                                    textColor: .primary.opacity(0.8)
                                )
                            }.padding(16)
                        }.onTapGesture {
                            PlayDefaultFeedback().play()
                            gameInfo.multiChoice = lastMultiChoice
                            gameInfo.regionMode = lastRegionMode
                            gameInfo.region = lastRegion
                            gameInfo.difficulty = lastDifficulty
                            timerGlobal.showSetUp = false
                            coordinator.show(Start.self)
                        }
                        .padding(.horizontal, 16)
                    }

                    //MARK: Set Up Game ----------------------------
                    ZStack{
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(CustomColor.primary)
                            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                        VStack{
                            Text("\(Image(systemName: "slider.horizontal.3")) Set Up Game")
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg))
                        }.padding(16)
                    }.onTapGesture {
                        PlayDefaultFeedback().play()
                        timerGlobal.showSetUp = true
                        coordinator.show(Start.self)
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 20)
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
