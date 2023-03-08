//
//  LBGameInfoList.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/10/23.
//

import SwiftUI

struct LBGameInfoList: View {
    var gameMode: String
    var gameDiff: String
    
    var body: some View {
        //for each element returned from the remote data base for this particular game setup show a gameInfo View
        LBGameInfoCard()
    }
}

struct LBGameInfoList_Previews: PreviewProvider {
    static var previews: some View {
        LBGameInfoList(gameMode: "World", gameDiff: "Easy")
    }
}
