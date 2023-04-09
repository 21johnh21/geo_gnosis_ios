//
//  LeaderboardCard.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 4/9/23.
//

import SwiftUI

struct LeaderboardCard: View {
    
    var lbData: LBData
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous).fill(CustomColor.primary)
            HStack(spacing: 0){
                StdText(textIn: lbData.userName).padding(.leading)
                Spacer()
                StdText(textIn: "Final Score: \(lbData.finalScore)").padding(.trailing)
            }.frame(height: 80)
        }
    }
}

//struct LeaderboardCard_Previews: PreviewProvider {
//    static var previews: some View {
//        LeaderboardCard()
//    }
//}
