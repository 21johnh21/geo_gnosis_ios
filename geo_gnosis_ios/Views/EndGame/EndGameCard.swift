//
//  EndGameCard.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/28/23.
//

import SwiftUI

struct EndGameCard: View {
    
    var location: Location
    var roundNumber: Int
    var time: Int
    var answer: Bool
    
    //TODO: Jump to the corresponding location on map when a card is clicked
    
    var body: some View {
        if(answer){
            ZStack{
                RoundedRectangle(cornerRadius: 25, style: .continuous).fill(CustomColor.primary)
                VStack{
                    HStack{
                        Text("Round: \(roundNumber)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)).padding()
                        if(time != -1){
                            Text("Score: \(time)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)).padding()
                        }else{
                            Text("Score: DNF").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)).padding()
                        }
                    }
                    HStack{
                        Text("\(location.city_ascii) \(Image(systemName: "circle.fill")) \(location.admin_name) \(Image(systemName: "circle.fill"))  \(location.country)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    }
                }
            }.frame(height: 100)
        }
    }
}


