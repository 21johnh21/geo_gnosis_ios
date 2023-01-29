//
//  EndGameCard.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/28/23.
//

import SwiftUI

struct EndGameCard: View {
    
//    @EnvironmentObject var gameInfo : GameInfo
//    var round : Int
//    var country: String
//    var state: String
//    var city: String
    
    var location : Location
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous).fill(.green)
            VStack{
                HStack{
                    Text("Round \(String(1)): ").padding()
                    Text("0:00").padding()
                }
                HStack{
                    Text("\(location.city_ascii) \(location.admin_name), \(location.country)")
                }
            }
        }.frame(height: 100)
    }
}

//struct EndGameCard_Previews: PreviewProvider {
//    static var previews: some View {
//        EndGameCard(location: Location())
//}
