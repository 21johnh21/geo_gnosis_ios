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
    @AppStorage("lastRegion") var lastRegion: String = Const.modeRegCountryText
    @AppStorage("lastDifficulty") var lastDifficulty: String = Const.modeDiffEasyText
    
    @EnvironmentObject var gameInfo: GameInfo
    @StateObject private var coordinator = Coordinator()
    @EnvironmentObject var timerGlobal: TimerGlobal
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ScrollView{
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 80)
                    Text("Geo Gnosis").font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg)).padding(.top)
                }
                Image(Const.picLogo).resizable().frame(width: 255, height: 255).clipShape(Circle()).padding()
                //MARK: Play Again Button ---------------------------------
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(CustomColor.primary)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    VStack{
                        Text("\(Image(systemName: "play.fill")) Play Again").font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg))
                        let lastMultiChoiceText = lastMultiChoice ? Const.modeMultiChoiceText : Const.modeFillBlankText
                        let lastRegionText = lastRegion == Const.modeRegCountryText ? "World" : lastRegion
                        Text("\(lastMultiChoiceText) \(Image(systemName: "circle.fill")) \(lastRegionMode) \(Image(systemName: "circle.fill")) \(lastRegionText) \(Image(systemName: "circle.fill")) \(lastDifficulty)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    }.padding()
                }.onTapGesture {
                    PlayDefaultFeedback().play()
                    gameInfo.multiChoice = lastMultiChoice
                    gameInfo.regionMode = lastRegionMode
                    gameInfo.region = lastRegion
                    gameInfo.difficulty = lastDifficulty
                    timerGlobal.showSetUp = false
                    coordinator.show(Start.self)
                }
                //MARK: Set Up Game ----------------------------
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(CustomColor.primary).shadow(color: .black, radius: 3, x: 2, y: 2)
                    VStack{
                        Text("\(Image(systemName: "gear")) Set Up Game").font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg))
                    }.padding()
                }.onTapGesture {
                    timerGlobal.showSetUp = true
                    coordinator.show(Start.self)
                }
                //MARK: Other buttons ------------------------------------------
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).shadow(color: .black, radius: 3, x: 2, y: 2)
                        Text("Settings").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    }.onTapGesture {
                        PlayDefaultFeedback().play()
                        coordinator.show(Settings.self)
                    }
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).shadow(color: .black, radius: 3, x: 2, y: 2)
                        Text("Leaderboard").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    }.onTapGesture {
                        PlayDefaultFeedback().play()
                        coordinator.show(LeaderBoard.self)
                    }
                }
                
                if(false){
                
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                        Text("DEV - Test Haptic")
                    }.onTapGesture {
                        PlayDefaultFeedback().play()
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
                        let region = Const.modeRegCountryText
                        let times = [10, 50, 20, 15, 5]
                        let city_ascii = ["NY", "NY", "NY", "NY", "NY"]
                        let lat = [50.12345, 50.0, 50.0, 50.0, 50.0]
                        let lng = [90.0, 90.0, 90.0, 90.0, 90.0]
                        let country = ["US", "US", "US", "US", "US"]
                        let admin_name = ["NY", "NY", "NY", "NY", "NY"]
                        let capital = ["No", "No", "No", "No", "No"]
                        let population = [1000000, 1000000, 1000000, 1000000, 1000000]
                        
                        //End test data
                        
                        let lbInfo = LBInfo(userName: userName, finalScore: finalScore, dateTime: GetFormattedDate(), multiChoice: multiChoice, regionMode: regionMode, difficulty: difficulty, region: region, times: times, city_ascii: city_ascii, lat: lat, lng: lng, country: country, admin_name: admin_name, capital: capital, population: population)
                        
                        let db = Firestore.firestore()
                        do {
                            try db.collection(Const.dbScoreCollection).document(UUID().uuidString).setData(from: lbInfo)
                        } catch let error {
                            print("Error writing city to Firestore: \(error)")
                        }
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
            }
            .background(alignment: .center){BackgroundView()}
        }
        .environmentObject(coordinator)
    }
    func GetFormattedDate() -> String{
        let date = Date()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"

        let dateString = formatter.string(from: date)
        return dateString
    }
}
