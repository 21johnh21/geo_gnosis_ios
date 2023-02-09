//
//  LeaderBoard.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/7/23.
//

import SwiftUI

struct LeaderBoard: View {
    var body: some View {
        TabView{
            ModeView()
            ModeView()
        }.tabViewStyle(.page(indexDisplayMode: .always))
    }
}


struct ModeView: View {
    var body: some View {
        VStack{
            Text("Multi Choice")//pas this in
            //rect with text
                //three diffs in rectangles
                    // on click expand to scroll
                        //on click of each game give details
                    
            //somehow highlight where the user's games are 
        }
    }
}


struct LeaderBoard_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoard()
    }
}
