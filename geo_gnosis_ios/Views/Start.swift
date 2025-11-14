//
//  start.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//

import SwiftUI
import AVFAudio

struct Start: View {
    
    @AppStorage("lastMultiChoice") var lastMultiChoice: Bool = true
    @AppStorage("lastRegionMode") var lastRegionMode: String = Const.modeRegCountryText
    @AppStorage("lastRegion") var lastRegion: String = Const.modeRegCountryText
    @AppStorage("lastDifficulty") var lastDifficulty: String = Const.modeDiffEasyText
    @AppStorage("sateliteMapOn") var sateliteMapOn: Bool = true
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var roundInfo: RoundInfo
    @EnvironmentObject var gameInfo: GameInfo
    @EnvironmentObject var timerGlobal: TimerGlobal
    
    @State var round: Int = 0
    @State var multiChoice = Const.modeMultiChoiceText
    @State var difficulty = Const.modeDiffEasyText
    @State var regionMode = Const.modeRegCountryText
    @State var region = "World"
    @State var isGameInitiated: Bool = false
    
    let numberOfRounds = 5
    
    var body: some View {
        
            ScrollView{
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 80)
                    Text("Geo Gnosis").font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg)).padding(.top).padding(.top)
                }
                if(!timerGlobal.showSetUp){
                    Image(Const.picLogo).resizable().frame(width: 255, height: 255).clipShape(Circle()).padding()
                    ZStack{
                        RoundedRectangle(cornerRadius: 5, style: .continuous).fill(CustomColor.primary)
                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                        VStack(spacing: 12){
                            // Game settings display
                            GameSettingsDisplay(
                                multiChoice: gameInfo.multiChoice,
                                difficulty: gameInfo.difficulty,
                                regionMode: gameInfo.regionMode,
                                region: gameInfo.region,
                                sateliteMapOn: sateliteMapOn
                            )
                        }.padding()
                    }
                }else{
                    SetUpGame(multiChoice: $multiChoice, difficulty: $difficulty, regionMode: $regionMode, region: $region)
                }

                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                        .frame(width: 200, height: 80)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    Text("\(Image(systemName: "play.fill")) Start").font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg)).padding(.top)
                }
                .padding(.bottom)
                .onTapGesture {
                    if(!isGameInitiated){
                        isGameInitiated = true
                        PlayDefaultFeedback().play()
                        startGame()
                    }
                }
            }.frame(maxWidth: .infinity)
            .background(alignment: .center){BackgroundView()}
    }
    func startGame(){

        getSetUpData()

        if(gameInfo.region == "World"){
            gameInfo.region = Const.modeRegCountryText
        }
        if(gameInfo.regionMode == Const.modeRegCountryText){
            gameInfo.region = Const.modeRegCountryText
        }

        timerGlobal.timerGlobal = Const.maxRoundScoreValue
        if(gameInfo.multiChoice){ //if multiple choice get the multi choice options
            roundInfo.multiChoiceOptions = RoundData(multiChoice: gameInfo.multiChoice, difficulty: gameInfo.difficulty, regionMode: gameInfo.regionMode, region: gameInfo.region).multiChoiceOptions
            if(roundInfo.locations.count>0){
                roundInfo.locations.removeAll()
            }
            for i in 0...numberOfRounds-1{
                roundInfo.locations.append(roundInfo.multiChoiceOptions[i][0])
            }
        }else{ // just get the correct locations
            roundInfo.locations = RoundData(multiChoice: gameInfo.multiChoice, difficulty: gameInfo.difficulty, regionMode: gameInfo.regionMode, region: gameInfo.region).locations
        }
        roundInfo.roundNumber = 0
        roundInfo.times = [0, 0, 0, 0, 0] //change how this is done later
        roundInfo.roundNumbers = [0, 0, 0, 0, 0]
        roundInfo.answers = [false, false, false, false, false]
        coordinator.show(GameMap.self)
    }
    func getSetUpData() {

        if(timerGlobal.showSetUp){
            gameInfo.multiChoice = multiChoice == Const.modeMultiChoiceText ? true : false
            gameInfo.difficulty = difficulty
            gameInfo.regionMode = regionMode
            gameInfo.region = region

            lastMultiChoice = gameInfo.multiChoice
            lastRegionMode = gameInfo.regionMode
            lastRegion = gameInfo.region
            lastDifficulty = gameInfo.difficulty
        }else{
            gameInfo.multiChoice = lastMultiChoice
            gameInfo.difficulty = lastDifficulty
            gameInfo.regionMode = lastRegionMode
            gameInfo.region = lastRegion
        }
    }
}
