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
import FirebaseFirestore
import FirebaseFirestoreSwift





struct EndGame: View {
    //private let database = Database.database().reference()
    
    //var ref: DatabaseReference!
    //var ref = Database.database().reference()
    let database = Firestore.firestore()
    //let docRef = database.document("")//coloection/document
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("loggedIn") var loggedIn: Bool = false
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var roundInfo : RoundInfo
    @EnvironmentObject var gameInfo: GameInfo
    
    @State var finalScore: Int = 0
    
    var roundNumber: Int = 0
    //var lbInfo = LBInfo()
    
    var body: some View {
//        let docRef = database.document("")//coloection/document
//        docRef.getDocument { snapshot, error in
//            guard let data = snapshot?.data(), error == nil else{
//                return
//            }
//            print(data)
//        }
        VStack {
            VStack{
            Text("Game Over!").font(.custom("Changa-Light", size: 40)).padding()
            HStack {
                Text("Final Score: ").font(.custom("Changa-Light", size: 16)).padding(.leading)
                Spacer()
                Text("\(CalcFinalScore())").font(.custom("Changa-Light", size: 16)).padding(.trailing)
            }
            
            }.background(){
                RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
            }
            
            MapView2(pinLocations: InitPinLocations())
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green).frame(height: 30)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    Text("Play Again").font(.custom("Changa-Light", size: 16))
                }.onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    coordinator.show(Start.self)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green).frame(height: 30)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    Text("Return to Menu").font(.custom("Changa-Light", size: 16))
                }.onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    SendResultsToDB() //TODO: Make sure this is always called
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
        
        var lbInfo = LBInfo(userName: userName, finalScore: finalScore, multiChoice: gameInfo.multiChoice, regionMode: gameInfo.regionMode, difficulty: gameInfo.difficulty, region: gameInfo.region, times: roundInfo.times, city_ascii: city_asciis, lat: lats, lng: lngs, country: countrys, admin_name: admin_names, capital: capitals, population: populations)
        
//                    var lbInfo = LBInfo(userName: "JH_DEV", finalScore: finalScore)
        let db = Firestore.firestore()
        do {
            try db.collection("Score Collection").document(UUID().uuidString).setData(from: lbInfo)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
        
//        var lbInfo = LBInfo(userName: "JH_DEV", finalScore: finalScore)
//        let db = Firestore.firestore()
//        do {
//            try db.collection("Score Collection").document(UUID().uuidString).setData(from: lbInfo)
//        } catch let error {
//            print("Error writing city to Firestore: \(error)")
//        }
        
    }
}

struct EndGame_Previews: PreviewProvider {
    static var previews: some View {
        EndGame()
    }
}
