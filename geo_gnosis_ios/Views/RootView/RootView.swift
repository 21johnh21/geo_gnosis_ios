//
//  RootView.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/25/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore //remove after test
import FirebaseFirestoreSwift //remove after test

struct RootView: View {
    
    @AppStorage("lastMultiChoice") var lastMultiChoice: Bool = true
    @AppStorage("lastRegionMode") var lastRegionMode: String = Const.modeRegCountryText
    @AppStorage("lastRegion") var lastRegion: String = "World"
    @AppStorage("lastDifficulty") var lastDifficulty: String = Const.modeDiffEasyText
    @AppStorage("vibOn") var vibOn: Bool = true
    
    @EnvironmentObject var gameInfo: GameInfo
    @StateObject private var coordinator = Coordinator()
    @State var multiChoice = "Multiple Choice"
//    var multiChoiceModes = ["Multiple Choice", "Fill the Blank"]
    @State var difficulty = "Easy"
//    var difficulties = ["Easy", "Medium", "Hard"]
    @State var regionMode = "World"
//    var regionModes = ["World", "State", "City"]
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var body: some View {
        
        NavigationStack(path: $coordinator.path) {
            
            ScrollView{
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 80)
                    Text("Geo Gnosis").font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg)).padding(.top)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(CustomColor.primary)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                        
                    VStack{
                        HStack{
                            Text("Play Again").font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg))
                            Image(systemName: "play.fill").font(.system(size: 25, weight: .bold))
                        }
                        let lastMultiChoiceText = lastMultiChoice ? "Multiple Choice" : "Fill the Blank"
                        Text("\(lastMultiChoiceText) \(Image(systemName: "circle.fill")) \(lastRegionMode) \(Image(systemName: "circle.fill")) \(lastRegion) \(Image(systemName: "circle.fill")) \(lastDifficulty)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    }.padding()
                }.onTapGesture {
                    if(vibOn){
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                    }
                    gameInfo.multiChoice = lastMultiChoice
                    gameInfo.regionMode = lastRegionMode
                    gameInfo.region = lastRegion
                    gameInfo.difficulty = lastDifficulty
                    coordinator.show(Start.self)
                }
                SetUpGame(multiChoice: $multiChoice, difficulty: $difficulty, regionMode: $regionMode)
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(CustomColor.primary)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    VStack{
                        HStack{
                            Text("Start").font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg))
                            Image(systemName: "play.fill").font(.system(size: 25, weight: .bold))
                        }
                    }.padding()
                }.onTapGesture {
                    if(vibOn){
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                    }
                    gameInfo.multiChoice = multiChoice == "Multiple Choice" ? true : false
                    gameInfo.difficulty = difficulty
                    gameInfo.regionMode = regionMode
                    
                    lastMultiChoice = gameInfo.multiChoice
                    lastRegionMode = gameInfo.regionMode
                    lastRegion = gameInfo.region
                    lastDifficulty = gameInfo.difficulty
                    
                    coordinator.show(Start.self)
                }
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).shadow(color: .black, radius: 3, x: 2, y: 2)
                        Text("Settings").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    }.onTapGesture {
                        if(vibOn){
                            let generator = UIImpactFeedbackGenerator(style: .light)
                            generator.impactOccurred()
                        }
                        coordinator.show(Settings.self)
                    }
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).shadow(color: .black, radius: 3, x: 2, y: 2)
                        Text("Leaderboard").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    }.onTapGesture {
                        if(vibOn){
                            let generator = UIImpactFeedbackGenerator(style: .light)
                            generator.impactOccurred()
                        }
                        coordinator.show(LeaderBoard.self)
                    }
                }
                
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                    Text("DEV - Test Haptic")
                }.onTapGesture {
                    if(vibOn){
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                    }
                    coordinator.show(DevTestHapticFeedback.self)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                    Text("DEV - Test DB")
                }.onTapGesture {
                    //test data
                    let userName = "DEV_JH"
                    let finalScore = 100
                    let multiChoice = true
                    let regionMode = Const.modeRegCountryText
                    let difficulty = Const.modeDiffEasyText
                    let region = "World"
                    let times = [10, 50, 20, 15, 5]
                    let city_ascii = ["NY", "NY", "NY", "NY", "NY"]
                    let lat = [50.12345, 50.0, 50.0, 50.0, 50.0]
                    let lng = [90.0, 90.0, 90.0, 90.0, 90.0]
                    let country = ["US", "US", "US", "US", "US"]
                    let admin_name = ["NY", "NY", "NY", "NY", "NY"]
                    let capital = ["No", "No", "No", "No", "No"]
                    let population = [1000000, 1000000, 1000000, 1000000, 1000000]
                    
                    //End test data
                    
                    let lbInfo = LBInfo(userName: userName, finalScore: finalScore, dateTime: Date(), multiChoice: multiChoice, regionMode: regionMode, difficulty: difficulty, region: region, times: times, city_ascii: city_ascii, lat: lat, lng: lng, country: country, admin_name: admin_name, capital: capital, population: population)
                    
//                    var lbInfo = LBInfo(userName: "JH_DEV", finalScore: finalScore)
                    let db = Firestore.firestore()
                    do {
                        try db.collection(Const.dbScoreCollection).document(UUID().uuidString).setData(from: lbInfo)
                    } catch let error {
                        print("Error writing city to Firestore: \(error)")
                    }
                }
            }
            .navigationDestination(for: String.self) { id in
                if id == String(describing: Start.self) {
                    Start()
                } else if id == String(describing: GameMap.self) {
                    GameMap()
                }
                else if id == String(describing: EndGame.self){
                    EndGame()
                }
                else if id == String(describing: Settings.self){
                    Settings()
                }
                else if id == String(describing: LeaderBoard.self){
                    LeaderBoard()
                }
                else if id == String(describing: LogIn.self){
                    LogIn()
                }
                else if id == String(describing: DevTestHapticFeedback.self){
                    DevTestHapticFeedback()
                }
                
            }.background(CustomColor.secondary)
        }
        .environmentObject(coordinator)
    }
//    func GetDiffIntValue(textValue: String) -> Int{
//        var intValue: Int
//        intValue = difficulties.firstIndex(of: textValue)!
//        return intValue + 1
//    }
//    func GetRegModeIntValue(textValue: String) -> Int{
//        var intValue: Int
//        intValue = regionModes.firstIndex(of: textValue)!
//        return intValue + 1
//    }
}
