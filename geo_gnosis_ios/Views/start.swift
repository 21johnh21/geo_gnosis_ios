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
    //var applicationInfo: ApplicationInfo
    
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
                    
                    //put multiChoiceOptions into round Info
                    // make multiChoiceOptions an array of arrays with 4 options each
                    // associate those options with each location, but only do this if it is a multi choice game
                    //I could possibly return this array from the 
                    
                    roundInfo.locations =
                    LocationData(multiChoice: gameInfo.multiChoice, multiChoiceOptions: gameInfo.multiChoiceOptions)
                        .locations
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
