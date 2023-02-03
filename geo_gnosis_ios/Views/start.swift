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
        
        NavigationView {
            VStack{
                Text("Game Mode").font(.title).padding(.top)
                Image("worldLogo2")
                Spacer()
                
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green)
                        .frame(width: 200, height: 80)
                    Text("Start").font(.title).padding(.top)
                }
                .padding(.bottom)
                .onTapGesture {
                    
                    if(gameInfo.multiChoice){ //if multiple choice get the multi choice options
                        roundInfo.multiChoiceOptions = RoundData(multiChoice: true).multiChoiceOptions
                        if(roundInfo.locations.count>0){
                            roundInfo.locations.removeAll()
                        }
                        for i in 0...numberOfRounds-1{
                            roundInfo.locations.append(roundInfo.multiChoiceOptions[i][0])
                        }
                    }else{ // just get the correct locations
                        roundInfo.locations = RoundData(multiChoice: false).locations
                    }
                    roundInfo.roundNumber = 0
                    roundInfo.times = [0, 0, 0, 0, 0] //change how this is done later 
                    roundInfo.roundNumbers = [0, 0, 0, 0, 0]
                    roundInfo.answers = [false, false, false, false, false]
                    coordinator.show(GameMap.self)
                }
            }
        }
    }
}

struct start_Previews: PreviewProvider {
    static var previews: some View {
        Start()
    }
}
