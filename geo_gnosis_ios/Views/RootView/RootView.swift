//
//  RootView.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/25/23.
//

import Foundation
import SwiftUI

struct RootView: View {
    
    @AppStorage("lastMultiChoice") var lastMultiChoice: Bool = true
    @AppStorage("lastRegionMode") var lastRegionMode: String = "World"
    @AppStorage("lastRegion") var lastRegion: String = "World"
    @AppStorage("lastDifficulty") var lastDifficulty: String = "Easy"
    
    @EnvironmentObject var gameInfo: GameInfo
    @StateObject private var coordinator = Coordinator()
    @State var multiChoice = "Multiple Choice"
    var multiChoiceModes = ["Multiple Choice", "Fill the Blank"]
    @State var difficulty = "Easy"
    var difficulties = ["Easy", "Medium", "Hard"]
    @State var regionMode = "World"
    var regionModes = ["World", "State", "City"]
    
    let screenSize: CGRect = UIScreen.main.bounds
    //let screenWidth = screenSize.width
    @State var animationAmount = 0.0
    @State var animate = false
   @State var tapped = false
    
    var body: some View {
        
        //let screenWidth = screenSize.width
        
        NavigationStack(path: $coordinator.path) {
            
            ScrollView{
                Text("Geo Gnosis").font(.title)
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(CustomColor.primary)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                        //.scaleEffect(animationAmount)
                        //.offset(x: animate ? 5 : 0)
                        .rotationEffect(.degrees(animationAmount))
                    
                    
                        //.animation(.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 0.0,  initialVelocity: 20.0), value: animationAmount)
                    
                        .animation(animate ? Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 0.0,  initialVelocity: 20.0).repeatForever(autoreverses: true) : Animation.default, value: animationAmount)
                    
                        //.animation(.spring(response: 0.5, dampingFraction: 0.01, blendDuration: 1), value: animationAmount)
                    VStack{
                        HStack{
                            Text("Play Again").font(.title)
                            Image(systemName: "play.fill").font(.system(size: 25, weight: .bold))
                        }
                        let lastMultiChoiceText = lastMultiChoice ? "Multiple Choice" : "Fill the Blank"
                        Text("\(lastMultiChoiceText) \(lastRegionMode) \(lastRegion) \(lastDifficulty)")
                    }.padding()
                }.onTapGesture {
                    animationAmount = animationAmount + 1
                    animate.toggle()
                    tapped = true
                    gameInfo.multiChoice = lastMultiChoice
                    gameInfo.regionMode = lastRegionMode
                    gameInfo.region = lastRegion
                    gameInfo.difficulty = lastDifficulty
                    //coordinator.show(Start.self)
                }
                VStack{
                    Text("Set Up Game")
                    Picker("Choose a Mode", selection: $multiChoice){
                        ForEach(multiChoiceModes, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented).colorMultiply(CustomColor.primary).background(CustomColor.trim).cornerRadius(5)
                    
                    Picker("Choose a difficulty", selection: $difficulty){
                        ForEach(difficulties, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented).colorMultiply(CustomColor.primary).background(CustomColor.trim).cornerRadius(5)
                    
                    Picker("Choose a Region Mode", selection: $regionMode){
                        ForEach(regionModes, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented).colorMultiply(CustomColor.primary).background(CustomColor.trim).cornerRadius(5)
                    if(regionMode != "World"){
                        DropDown()
                    }
                }.padding().overlay(){
                    RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(CustomColor.primary)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                    VStack{
                        HStack{
                            Text("Start").font(.title)
                            Image(systemName: "play.fill").font(.system(size: 25, weight: .bold))
                        }
                    }.padding()
                }.onTapGesture {
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
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                        Text("Settings")
                    }.onTapGesture {
                        coordinator.show(Settings.self)
                    }
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                        Text("Leaderboard")
                    }.onTapGesture {
                        coordinator.show(LeaderBoard.self)
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
//                else if id == String(describing: RootView.self){
//                    RootView()
//                }
                else{
                    
                }
                
                
//                switch(id){
//                case (String(describing: start.self)):
//                    start()
//                case (String(describing: start.self)):
//                    map()
//                case (String(describing: start.self)):
//                    EndGame()
//                default (String(describing: start.self)):
//                    RootView()
//
//                }
            }.background(CustomColor.secondary)
        }
        .environmentObject(coordinator)
    }
}
