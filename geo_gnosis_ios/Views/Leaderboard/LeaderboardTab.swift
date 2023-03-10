//
//  LeaderboardTab.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/7/23.
//

import SwiftUI

struct LeaderboardTab: View {
    var multiChoice: Bool
    
    @State var regionMode: String = "World"
    var body: some View {
        VStack{
            let gameMode = multiChoice == true ? "Multiple Choice" : "Fill the Blank"
            VStack{
                Text("Leaderboard").font(.custom("BebasNeue-Regular", size: 45))
                Text("\(gameMode)").font(.custom("BebasNeue-Regular", size: 20))
            }.frame(maxWidth: .infinity).background(){
                RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
            }
                ScrollView{
                    VStack{
                        LeaderboardHeader(headerText: "World")
                        LBRegionModeSec(multiChoice: multiChoice, gameMode: "World")
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
        }.background(CustomColor.secondary)
    }
}

struct LeaderboardTab_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardTab(multiChoice: true)
    }
}
