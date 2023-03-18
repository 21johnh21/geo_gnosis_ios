//
//  LeaderBoard.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/7/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct LeaderBoard: View {
    
    var body: some View {
        TabView{
            UserHistory()
            LeaderboardTab(multiChoice: true)
            LeaderboardTab(multiChoice: false)
        }.tabViewStyle(.page(indexDisplayMode: .always))
            .background(alignment: .center){BackgroundView()}
    }
}

struct LeaderBoard_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoard()
    }
}
