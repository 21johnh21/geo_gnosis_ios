//
//  EndGame.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/23/23.
//

import SwiftUI
import MapKit
//import FirebaseCore
import Firebase
//import FirebaseAnalytics
//import FirebaseFirestoreSwift
//import FirebaseFirestore





struct EndGame: View {
    //private let database = Database.database().reference()
    
    //var ref: DatabaseReference!
    //var ref = Database.database().reference()
    
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("loggedIn") var loggedIn: Bool = false
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var roundInfo : RoundInfo
    @EnvironmentObject var gameInfo: GameInfo
    
    var roundNumber: Int = 0
    var lbInfo = LeaderboardInfo() 
    
    var body: some View {
        VStack {
            VStack{
            Text("Game Over!").padding()
            HStack {
                Text("Final Score: ").padding(.leading)
                Spacer()
                Text("\(CalcFinalScore())").padding(.trailing)
            }
            
            }.background(){
                RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
            }
            
            MapView2(pinLocations: InitPinLocations())
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green).frame(height: 30)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    Text("Play Again")
                }.onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    coordinator.show(Start.self)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green).frame(height: 30)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    Text("Return to Menu")
                }.onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    SendResultsToDB()
                    coordinator.popToRoot()
                }
            }
            
           
            ScrollView{
                
                ForEach(roundInfo.roundNumbers.indices) { index in
                    EndGameCard(location: roundInfo.locations[index], roundNumber: roundInfo.roundNumbers[index], time: roundInfo.times[index], answer: roundInfo.answers[index])
                }
            }
        }.navigationBarBackButtonHidden(true)
        .background(CustomColor.secondary)
    }
    
    func InitPinLocations() -> Array <PinLocation>{
        var pinLocations = [PinLocation]()
        var pinLocation = PinLocation(name: "", coordinate: CLLocationCoordinate2D(
            latitude: 0.0, longitude: 0.0))
        
        for i in 0...roundInfo.roundNumber{
            //var pinLocation: PinLocation
            pinLocation.coordinate = CLLocationCoordinate2D(
                latitude: roundInfo.locations[i].lat, longitude: roundInfo.locations[i].lng)
            pinLocation.name=""
            pinLocations.append(pinLocation)
        }
        return pinLocations
    }
    func CalcFinalScore() -> Int{
        var finalScore: Int = 0
        for i in 0...roundInfo.roundNumber{
            finalScore += roundInfo.times[i]
        }
        return finalScore
    }
    func SendResultsToDB(){
        lbInfo.userName = userName
        lbInfo.finalScore = CalcFinalScore()
        lbInfo.gameInfo = gameInfo
        lbInfo.roundInfo = roundInfo
        
//        var ref: DatabaseReference!
//
//        ref = Database.database().reference()
        
        
        
        
        
        
        
        //FIRApp.configure()
                
                //getting a reference to the node artists
        //let refArtists = FirebaseApp.database().reference().child("artists");
//        let databaseRef = FirebaseApp.app()
//        let key = FirebaseApp.app().key
//
//        let testData = ["testfield" : "test"]
//
//        databaseRef?.setValue("testfield", forKey: "testdata")
        
//        for i in 0...4{
//            lbInfo.roundInfo. = $roundInfo[i]
//        }
    }
}

struct EndGame_Previews: PreviewProvider {
    static var previews: some View {
        EndGame()
    }
}
