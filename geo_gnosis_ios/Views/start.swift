//
//  start.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//

import SwiftUI

struct Start: View {
    
    @State var round: Int = 0 
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var roundInfo: RoundInfo
    @EnvironmentObject var gameInfo: GameInfo
    
    let numberOfRounds = 5
    
    var body: some View {
        
        //NavigationView {
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 80)
                    Text("Geo Gnosis").font(.title).padding(.top)
                }
                //Image("worldLogo2")
                Image("logo").resizable().frame(width: 255, height: 255).clipShape(Circle()).padding()
                
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 80)
                    VStack(alignment: .center){
                       let gameMode = gameInfo.multiChoice == true ? "Multiple Choice" : "Fill the Blank"
                        Text("Game Mode \(Image(systemName: "circle.fill")) \(gameMode)")
                        Text("Region Mode \(Image(systemName: "circle.fill")) \(gameInfo.regionMode)")
                        if(gameInfo.regionMode != "World"){
                            Text("Region \(Image(systemName: "circle.fill")) \(gameInfo.region)")
                        }
                        Text("Difficulty \(Image(systemName: "circle.fill")) \(gameInfo.difficulty)")
                    }
                }
                //Image("logo").scaleEffect(0.1)

                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                        .frame(width: 200, height: 80)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    Text("Start").font(.title).padding(.top)
                }
                .padding(.bottom)
                .onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    StartGame()
                }
            }.frame(maxWidth: .infinity)
            .background(CustomColor.secondary)
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
