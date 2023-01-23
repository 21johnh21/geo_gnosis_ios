//
//  start.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//

import SwiftUI

struct start: View {
    
    let data = LocationData2().locations
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                NavigationLink(destination: map()){
                    Text("Start Game")
                }
            }
        }
    }
}

struct start_Previews: PreviewProvider {
    static var previews: some View {
        start()
    }
}
