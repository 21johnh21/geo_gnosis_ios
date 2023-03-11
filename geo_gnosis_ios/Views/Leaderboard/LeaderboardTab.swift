//
//  LeaderboardTab.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/7/23.
//

import SwiftUI

struct LeaderboardTab: View {
    var multiChoice: Bool
    
    @State var regionMode: Int = Const.modeRegCountry
    var body: some View {
        VStack{
            let gameMode = multiChoice == true ? "Multiple Choice" : "Fill the Blank"
            VStack{
                Text("Leaderboard").font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg))
                Text("\(gameMode)").font(.custom(Const.fontTitle, size: Const.fontSizeTitleSm))
            }.frame(maxWidth: .infinity).background(){
                RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
            }
                ScrollView{
                    VStack{
                        LeaderboardHeader(headerText: "World")
                        LBRegionModeSec(multiChoice: multiChoice, gameMode: Const.modeRegCountry)
                    }
                    VStack{
                        LeaderboardHeader(headerText: "Region")
                        LBRegionModeSec(multiChoice: multiChoice, gameMode: Const.modeRegRegion)
                    }
                    
                    VStack{
                        LeaderboardHeader(headerText: "City")
                        LBRegionModeSec(multiChoice: multiChoice, gameMode: Const.modeRegCity)
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
