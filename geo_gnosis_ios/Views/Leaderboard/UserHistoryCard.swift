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
                    
                    Text("\(lbData.userName)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)).padding()
                    Text("Final Score: \(lbData.finalScore)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)).padding()
                }
                HStack{
                    Text("\(GetGameMode()) \(Image(systemName: "circle.fill")) \(lbData.regionMode) \(Image(systemName: "circle.fill")) \(lbData.region) \(Image(systemName: "circle.fill")) \(lbData.difficulty)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                }
            }
        }.frame(height: 100)
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
