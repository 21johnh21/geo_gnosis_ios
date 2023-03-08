//
//  LBRegionModeSec.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/10/23.
//

import SwiftUI

struct LBRegionModeSec: View {
    
    var gameMode: String
    
    var body: some View {
        ScrollView{
            LeaderboardHeader(headerText: "Easy")
            LBGameInfoList(gameMode: gameMode, gameDiff: "Easy")
            LeaderboardHeader(headerText: "Medium")
            LBGameInfoList(gameMode: gameMode, gameDiff: "Medium")
            LeaderboardHeader(headerText: "Hard")
            LBGameInfoList(gameMode: gameMode, gameDiff: "Hard")
        }.padding(.trailing)
            .overlay(){
                RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2).padding(.trailing)
            }
    }
}

struct LBRegionModeSec_Previews: PreviewProvider {
    static var previews: some View {
        LBRegionModeSec(gameMode: "Easy")
    }
}
