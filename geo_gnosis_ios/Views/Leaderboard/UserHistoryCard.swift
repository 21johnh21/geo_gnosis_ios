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
            HStack(spacing: 0){
                VStack(alignment: .leading, spacing: 0){
                    StdText(textIn: lbData.userName)
                    StdText(textIn: "Final Score: \(lbData.finalScore)")
                    
                }.padding(.leading)
                Spacer()
                VStack(alignment: .leading, spacing: 0){
                    StdText(textIn: "Game Mode: \(GetGameMode())")
                    StdText(textIn: "Difficulty: \(lbData.difficulty)")
                    StdText(textIn: "Region Mode: \(lbData.regionMode)")
                    StdText(textIn: "Region: \(lbData.region)")
                }.padding(.trailing)
            }
        }.frame(height: 130)
    }
        
    func GetGameMode() -> String{
        if(lbData.multiChoice){
            return Const.modeMultiChoiceText
        }else{
            return Const.modeFillBlankText
        }
    }
}

//struct UserHistoryCard_Previews: PreviewProvider {
//    static var previews: some View {
//        //UserHistoryCard()
//    }
//}
