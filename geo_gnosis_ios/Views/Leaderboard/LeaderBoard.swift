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
    
    //@State var regionMode: String = "Country"
    
    var body: some View {
        TabView{
            UserHistory()
            ModeView()
            ModeView()
        }.tabViewStyle(.page(indexDisplayMode: .always))
    }
}


struct ModeView: View {
    @State var regionMode: String = "Country"
    var body: some View {
        VStack{
            Text("Leaderboard").font(.title)
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
    func GetData(){
        let db = Firestore.firestore()
        let docRef = db.collection("Score Collection").whereField("multiChoice", isEqualTo: true).whereField("multiChoice", isEqualTo: true).order(by: "finalScore").limit(to: 5) //something like this? how can I have multiple criteria?
        
        //order data here, or maybe I can do that on the backend
        //query data that meets criteria for each category
        
    }
}


struct LeaderBoard_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoard()
    }
}
