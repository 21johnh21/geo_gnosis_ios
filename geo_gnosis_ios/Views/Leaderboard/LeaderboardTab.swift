//
//  LeaderboardTab.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/7/23.
//

import SwiftUI

struct LeaderboardTab: View {
    var multiChoice: Bool
    
    @State var regionMode: String = "Country"
    var body: some View {
        VStack{
            Text("Leaderboard").font(.title)
            //HStack{
                ScrollView{
                    VStack{
                        LeaderboardHeader(headerText: "Country")
                        LBRegionModeSec(multiChoice: multiChoice, gameMode: "Country")
                    }
                    VStack{
                        LeaderboardHeader(headerText: "Region")
                        LBRegionModeSec(multiChoice: multiChoice, gameMode: "Region")
                    }
                    
                    VStack{
                        LeaderboardHeader(headerText: "City")
                        LBRegionModeSec(multiChoice: multiChoice, gameMode: "City")
                    }
                
                }
        }
    }
}

struct LeaderboardTab_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardTab(multiChoice: true)
    }
}
