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
                HStack(spacing: 0){
                    VStack(alignment: .leading, spacing: 0){
                        StdText(textIn: "Round: \(roundNumber)")
                        if(time != -1){
                            StdText(textIn: "Score: \(time)")
                        }else{
                            StdText(textIn: "Score: DNF")
                        }
                    }.padding(.leading)
                    Spacer()
                    VStack(alignment: .leading, spacing: 0){
                        StdText(textIn: "City: \(location.city_ascii)")
                        StdText(textIn: "District: \(location.admin_name)")
                        StdText(textIn: "Country: \(location.country)")
                    }.padding(.trailing)
                }
            }.frame(height: 130)
        }
    }
}


