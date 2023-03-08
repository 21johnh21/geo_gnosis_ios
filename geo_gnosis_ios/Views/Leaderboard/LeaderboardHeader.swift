//
//  LeaderboardHeader.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/10/23.
//

import SwiftUI

struct LeaderboardHeader: View {
    
    var headerText : String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height:
            30)
            Text("\(headerText)")
            
        }
    }
}

struct LeaderboardHeader_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardHeader(headerText: "Sample")
    }
}
