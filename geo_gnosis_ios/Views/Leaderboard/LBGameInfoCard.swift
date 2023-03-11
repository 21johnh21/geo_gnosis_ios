//
//  LBGameInfoCard.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/10/23.
//

import SwiftUI

struct LBGameInfoCard: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25).fill(.green).frame(height: 50)
            HStack{
                Text("User Name").padding(.leading)
                Spacer()
                Text("Score").padding(.trailing)
            }
        }.onTapGesture {
            LBGameDetail() //TODO: 
        }
    }
}

struct LBGameInfo_Previews: PreviewProvider {
    static var previews: some View {
        LBGameInfoCard()
    }
}
