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
                        LBRegionModeSec(gameMode: "Country")
                    }
                    VStack{
                        LeaderboardHeader(headerText: "Region")
                        LBRegionModeSec(gameMode: "Region")
                    }
                    
                    VStack{
                        LeaderboardHeader(headerText: "City")
                        LBRegionModeSec(gameMode: "City")
                    }
                
                }
//                ScrollView{
//                    Text("Fill the Blank")
//                    LeaderboardHeader(headerText: "Country")
//                    LeaderboardHeader(headerText: "Region")
//                    LeaderboardHeader(headerText: "City")
//                }
           // }
        }
    }
}

struct LeaderboardTab_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardTab(multiChoice: true)
    }
}
