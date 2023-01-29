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
    @EnvironmentObject var gameInfo: GameInfo
    var body: some View {
        
        NavigationView {
            VStack{
                Text("Game Mode").font(.title).padding(.top)
                Image("worldLogo2")
                //Text("Game Mode").font(.headline).padding()
                Spacer()
                
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green)
                        .frame(width: 200, height: 80)
                    Text("Start").font(.title).padding(.top)
                }
                .padding(.bottom)
                .onTapGesture {
                    gameInfo.locations = LocationData().locations
                    gameInfo.roundNumber = 0
                    coordinator.show(GameMap.self)
                }
                
//                Button {
//                    gameInfo.locations = LocationData().locations
//                    gameInfo.roundNumber = 0
//                    coordinator.show(GameMap.self)
//                } label: {
//                    Text("Start Game")
//                }
            }
        }
    }
}

struct start_Previews: PreviewProvider {
    static var previews: some View {
        Start()
    }
}
