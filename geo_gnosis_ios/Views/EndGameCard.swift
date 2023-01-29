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
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous).fill(.green)
            VStack{
                HStack{
                    Text("Round: \(roundNumber)").padding()
                    Text("Score: \(time)").padding()
                }
                HStack{
                    Text("\(location.city_ascii) \(location.admin_name), \(location.country)")
                }
            }
        }.frame(height: 100)
    }
}


