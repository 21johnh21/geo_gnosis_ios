//
//  LeaderBoard.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/7/23.
//

import SwiftUI

struct LeaderBoard: View {
    
    //@State var regionMode: String = "Country"
    
    var body: some View {
        TabView{
            ModeView()
            ModeView()
        }.tabViewStyle(.page(indexDisplayMode: .always))
    }
}


struct ModeView: View {
    @State var regionMode: String = "Country"
    var body: some View {
        VStack{
            Text("Multiple Choice")
            HStack{
                ScrollView{
                    Text("Multiple Choice")
                    LeaderboardHeader(headerText: "Country").onTapGesture {
                        regionMode = "Country"
                    }
                    if(regionMode == "Country"){
                       LBRegionModeSec()
                    }
                        LeaderboardHeader(headerText: "Region").onTapGesture {
                            regionMode = "Region"
                        }
                    if(regionMode == "Region"){
                        LBRegionModeSec()
                    }
                    LeaderboardHeader(headerText: "City").onTapGesture {
                        regionMode = "City"
                    }
                    if(regionMode == "City"){
                        LBRegionModeSec()
                    }
                }
                ScrollView{
                    Text("Fill the Blank")
                    LeaderboardHeader(headerText: "Country")
                    LeaderboardHeader(headerText: "Region")
                    LeaderboardHeader(headerText: "City")
                }
            }
            
            
            //Text("Multi Choice")//pas this in
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
