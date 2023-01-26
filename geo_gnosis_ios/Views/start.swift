//
//  start.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//

import SwiftUI

struct start: View {
    
    let data = LocationData2().locations
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        
        NavigationView {
            VStack{
                Text("Start Game").font(.title).padding(.top)
                Image("worldLogo2")
                Text("Game Mode").font(.headline).padding()
                Spacer()
                
                Button {
                    coordinator.show(map.self)
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
        start()
    }
}
