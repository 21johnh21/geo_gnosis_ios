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
    @State var multiChoice = Const.modeMultiChoiceText
    @State var difficulty = Const.modeDiffEasyText
    @State var regionMode = Const.modeRegCountryText
    @State var showSetUp = false
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var body: some View {
        
        NavigationStack(path: $coordinator.path) {
            
            ScrollView{
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 80)
                    Text("Geo Gnosis").font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg)).padding(.top)
                }
                //MARK: Play Again Button ---------------------------------
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(CustomColor.primary)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                        
                    VStack{
                        HStack{
                            Image(systemName: "play.fill").font(.system(size: 25, weight: .bold))
                            Text("Play Again").font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg))
                        }
                        let lastMultiChoiceText = lastMultiChoice ? Const.modeMultiChoiceText : Const.modeFillBlankText
                        Text("\(lastMultiChoiceText) \(Image(systemName: "circle.fill")) \(lastRegionMode) \(Image(systemName: "circle.fill")) \(lastRegion) \(Image(systemName: "circle.fill")) \(lastDifficulty)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    }.padding()
                }.onTapGesture {
                    PlayDefaultFeedback().play()
                    gameInfo.multiChoice = lastMultiChoice
                    gameInfo.regionMode = lastRegionMode
                    gameInfo.region = lastRegion
                    gameInfo.difficulty = lastDifficulty
                    coordinator.show(Start.self)
                }
                //MARK: Set Up Game ----------------------------
                if(showSetUp){
                    SetUpGame(multiChoice: $multiChoice, difficulty: $difficulty, regionMode: $regionMode)
                }else{
                    ZStack{
                        RoundedRectangle(cornerRadius: 5, style: .continuous).fill(CustomColor.primary)
                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                        VStack{
                            HStack{
                                Image(systemName: "gear").font(.system(size: 25, weight: .bold))
                                Text("Set Up Game").font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg))
                            }
                        }.padding()
                    }.onTapGesture {
                        showSetUp.toggle()
                    }
                }
                //MARK: Start Buton ----------------------------
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(CustomColor.primary)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    VStack{
                        HStack{
                            Image(systemName: "play.fill").font(.system(size: 25, weight: .bold))
                            Text("Start").font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg))
                        }
                    }.padding()
                }.onTapGesture {
                    PlayDefaultFeedback().play()
                    gameInfo.multiChoice = multiChoice == Const.modeMultiChoiceText ? true : false
                    gameInfo.difficulty = difficulty
                    gameInfo.regionMode = regionMode
                    
                    lastMultiChoice = gameInfo.multiChoice
                    lastRegionMode = gameInfo.regionMode
                    lastRegion = gameInfo.region
                    lastDifficulty = gameInfo.difficulty
                    
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
            .onAppear(){
                showSetUp = false
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
