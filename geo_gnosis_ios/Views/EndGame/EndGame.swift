//
//  EndGame.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/23/23.
//

import SwiftUI
import MapKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct EndGame: View {
    let database = Firestore.firestore()
    
    @AppStorage("vibOn") var vibOn: Bool = true
    
    @AppStorage("userName") var userNameSt: String = ""
    @AppStorage("userID") var userIDSt: String = ""
    @AppStorage("postScores") var postScores: Bool = true
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var roundInfo : RoundInfo
    @EnvironmentObject var gameInfo: GameInfo
    
    @State var finalScore: Int = 0
    
    //var roundNumber: Int = 0

    var body: some View {
        VStack {
            VStack{
            Text("Game Over!").font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg)).padding()
            HStack {
                Text("Final Score: ").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)).padding(.leading)
                Spacer()
                Text("\(finalScore)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)).padding(.trailing)
            }
            
            }.background(){
                RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
            }
            
            MapView2(pinLocations: InitPinLocations())
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green).frame(height: 30)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    Text("Play Again").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                }.onTapGesture {
                    if(vibOn){
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                    }
                    coordinator.show(Start.self)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green).frame(height: 30)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    Text("Return to Menu").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                }.onTapGesture {
                    if(vibOn){
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                    }
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
        .onAppear(){
            finalScore = CalcFinalScore()
            SendResultsToDB()
        }
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
        var finalScore: Int = Const.maxFinalScoreValue
        for i in 0...roundInfo.roundNumber{
            if(roundInfo.times[i] != -1){
                finalScore -= roundInfo.times[i]
            }else{
                let numOfRoundsUncomplete = Const.numOfRounds - i
                finalScore -= Const.maxRoundScoreValue * numOfRoundsUncomplete
            }
        }
        return finalScore
    }
    func SendResultsToDB(){
        let userName = userNameSt
        //If the user is logged in, allows posting scores
        if(userName != "" && postScores){
            var city_asciis: [String] = [String]()
            var lats: [Double] = [Double]()
            var lngs: [Double] = [Double]()
            var countrys: [String] = [String]()
            var admin_names: [String] = [String]()
            var capitals: [String] = [String]()
            var populations: [Int] = [Int]()
            
            for location in roundInfo.locations{
            city_asciis.append(location.city_ascii)
            lats.append(location.lat)
            lngs.append(location.lng)
            countrys.append(location.country)
            admin_names.append(location.admin_name)
            capitals.append(location.capital)
            populations.append(location.population)
            }
        
            let lbInfo = LBInfo(userName: userName, finalScore: finalScore, dateTime: Date(), multiChoice: gameInfo.multiChoice, regionMode: gameInfo.regionMode, difficulty: gameInfo.difficulty, region: gameInfo.region, times: roundInfo.times, city_ascii: city_asciis, lat: lats, lng: lngs, country: countrys, admin_name: admin_names, capital: capitals, population: populations)
        
            let db = Firestore.firestore()
            do {
                try db.collection(Const.dbScoreCollection).document(UUID().uuidString).setData(from: lbInfo)
            } catch let error {
                print("Error writing score to Firestore: \(error.localizedDescription)")
            }
        }
    }
}

struct EndGame_Previews: PreviewProvider {
    static var previews: some View {
        EndGame()
    }
}
