//
//  LBRegionModeSec.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/10/23.
//

import SwiftUI

struct LBRegionModeSec: View {
    var body: some View {
        ScrollView{
            LeaderboardHeader(headerText: "Easy").onTapGesture {
                
            }
            LeaderboardHeader(headerText: "Medium").onTapGesture {
                
            }
            LeaderboardHeader(headerText: "Hard").onTapGesture {
                
            }
        }.padding(.trailing)
            .overlay(){
                RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2).padding(.trailing)
            }
    }
}

struct LBRegionModeSec_Previews: PreviewProvider {
    static var previews: some View {
        LBRegionModeSec()
    }
}
