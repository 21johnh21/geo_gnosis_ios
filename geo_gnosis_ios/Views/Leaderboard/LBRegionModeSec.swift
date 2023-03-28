//
//  LBRegionModeSec.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/10/23.
//

import SwiftUI

struct LBRegionModeSec: View {
    
    var multiChoice: Bool
    var gameMode: String
    
    var body: some View {
        ScrollView{
            LeaderboardHeader(headerText: Const.modeDiffEasyText)
            LBGameInfoList(multiChoice: multiChoice, gameMode: gameMode, gameDiff: Const.modeDiffEasyText)
            LeaderboardHeader(headerText: Const.modeDiffMedText)
            LBGameInfoList(multiChoice: multiChoice, gameMode: gameMode, gameDiff: Const.modeDiffMedText)
            LeaderboardHeader(headerText: Const.modeDiffHardText)
            LBGameInfoList(multiChoice: multiChoice, gameMode: gameMode, gameDiff: Const.modeDiffHardText)
        }.padding(.trailing)
    }
}

struct LBRegionModeSec_Previews: PreviewProvider {
    static var previews: some View {
        LBRegionModeSec(multiChoice: true, gameMode: Const.modeRegCountryText)
    }
}
