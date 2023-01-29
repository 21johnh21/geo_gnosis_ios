//
//  start.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//

import SwiftUI

struct Start: View {
    
    //let data = LocationData().locations
    //@State var locations = LocationData().locations
    @State var round: Int = 0 
    @EnvironmentObject private var coordinator: Coordinator
    //@StateObject var gameInfo = GameInfo()
    //@EnvironmentObject var gameInfo: GameInfo
    @EnvironmentObject var gameInfo: GameInfo
    var body: some View {
        
        NavigationView {
            VStack{
                Text("Start Game").font(.title).padding(.top)
                Image("worldLogo2")
                Text("Game Mode").font(.headline).padding()
                Spacer()
                
                Button {
                    //@State var locations = LocationData().locations
                    //@StateObject var gameInfo = GameInfo()
                    //gameInfo.locations = locations
                    gameInfo.locations = LocationData().locations
                    gameInfo.roundNumber = 0
                    coordinator.show(GameMap.self)
                } label: {
                    Text("Start Game")
                }
//                NavigationLink(destination: map()){
//                    Text("Start Game").padding(.bottom)
            }
        }
    }
}

struct start_Previews: PreviewProvider {
    static var previews: some View {
        Start()
    }
}
