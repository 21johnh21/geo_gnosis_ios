//
//  EndGameCard.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/28/23.
//

import SwiftUI

struct EndGameCard: View {
    
    var round : Int
    var country: String
    var state: String
    var city: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous).fill(.green)
            VStack{
                HStack{
                    Text("Round \(String(round)): ").padding()
                    Text("0:00").padding()
                }
                HStack{
                    Text("\(city) \(state), \(country)")
                }
            }
        }.frame(height: 100)
    }
}

struct EndGameCard_Previews: PreviewProvider {
    static var previews: some View {
        EndGameCard(round: 1, country: "United States", state: "New york", city: "New York")
    }
}
