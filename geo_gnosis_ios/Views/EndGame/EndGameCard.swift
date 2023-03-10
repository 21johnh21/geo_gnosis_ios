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
    
    var body: some View {
        if(answer){
            ZStack{
                RoundedRectangle(cornerRadius: 25, style: .continuous).fill(CustomColor.primary)
                VStack{
                    HStack{
                        Text("Round: \(roundNumber)").font(.custom("Changa-Light", size: 16)).padding()
                        if(time != -1){
                            Text("Score: \(time)").font(.custom("Changa-Light", size: 16)).padding()
                        }else{
                            Text("Score: DNF").font(.custom("Changa-Light", size: 16)).padding()
                        }
                    }
                    HStack{
                        Text("\(location.city_ascii) \(Image(systemName: "circle.fill")) \(location.admin_name) \(Image(systemName: "circle.fill"))  \(location.country)").font(.custom("Changa-Light", size: 16))
                    }
                }
            }.frame(height: 100)
        }
    }
}


