//
//  start.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//

import SwiftUI
import AVFAudio

struct Start: View {
    
    @State var round: Int = 0 
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var roundInfo: RoundInfo
    @EnvironmentObject var gameInfo: GameInfo
    
    let numberOfRounds = 5
    
    var body: some View {
        
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 80)
                    Text("Geo Gnosis").font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg)).padding(.top).padding(.top)
                }
                Image(Const.picLogo).resizable().frame(width: 255, height: 255).clipShape(Circle()).padding()
                
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 80)
                    VStack(alignment: .center){
                        let gameMode = gameInfo.multiChoice == true ? Const.modeMultiChoiceText : Const.modeFillBlankText
                        Text("Game Mode \(Image(systemName: "circle.fill")) \(gameMode)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                        Text("Region Mode \(Image(systemName: "circle.fill")) \(gameInfo.regionMode)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                        if(gameInfo.regionMode != Const.modeRegCountryText){
                            Text("Region \(Image(systemName: "circle.fill")) \(gameInfo.region)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                        }
                        Text("Difficulty \(Image(systemName: "circle.fill")) \(gameInfo.difficulty)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    }.frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(maxWidth: .infinity))
                }

                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                        .frame(width: 200, height: 80)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    Text("Start").font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg)).padding(.top)
                }
                .padding(.bottom)
                .onTapGesture {
                    PlayDefaultFeedback().play()
                    StartGame()
                }
            }.frame(maxWidth: .infinity)
            .background(alignment: .center){BackgroundView()}
    }
    func StartGame(){
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
}

struct start_Previews: PreviewProvider {
    static var previews: some View {
        Start()
    }
}
