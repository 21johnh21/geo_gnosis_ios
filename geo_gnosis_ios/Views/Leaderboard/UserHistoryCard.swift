//
//  UserHistoryCard.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/6/23.
//

import SwiftUI

struct UserHistoryCard: View {
    var lbData: LBData
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous).fill(CustomColor.primary)
            VStack{
                HStack{
                    
                    Text("\(lbData.userName)").font(.custom("Changa-Light", size: 16)).padding()
                    Text("Final Score: \(lbData.finalScore)").font(.custom("Changa-Light", size: 16)).padding()
                }
                HStack{
                    Text("GameModePlaceHolder \(Image(systemName: "circle.fill")) \(lbData.regionMode) \(Image(systemName: "circle.fill")) \(lbData.region) \(Image(systemName: "circle.fill")) \(lbData.difficulty)").font(.custom("Changa-Light", size: 16))
                }
            }
        }.frame(height: 100)
    }
}

//struct UserHistoryCard_Previews: PreviewProvider {
//    static var previews: some View {
//        //UserHistoryCard()
//    }
//}
