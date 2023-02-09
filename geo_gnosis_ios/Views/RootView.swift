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

   
    
    var body: some View {
        
        //let screenWidth = screenSize.width
        
        NavigationStack(path: $coordinator.path) {
//            VStack {
//                Button {
//                    coordinator.show(Start.self)
//                } label: {
//                    Text("Show View A")
//                }
//                Button {
//                    coordinator.show(GameMap.self)
//                } label: {
//                    Text("Show View B")
//                }
            
            ScrollView{
                Text("Geo Gnosis").font(.title)
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.green)
                    VStack{
                        Text("Play Again").font(.title)
                        var lastMultiChoiceText = lastMultiChoice ? "Multiple Choice" : "Fill the Blank"
                        Text("\(lastMultiChoiceText) \(lastRegionMode) \(lastRegion) \(lastDifficulty)")
                    }.padding()
                }.onTapGesture {
                    gameInfo.multiChoice = lastMultiChoice
                    gameInfo.regionMode = lastRegionMode
                    gameInfo.region = lastRegion
                    gameInfo.difficulty = lastDifficulty
                    coordinator.show(Start.self)
                }
//                HStack{
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.green).frame(width: screenWidth/2)
//                        Text("Multiple Choice").font(.title)
//                    }.onTapGesture {
//                        gameInfo.multiChoice = true
//                    }.padding(.leading)
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.green).frame(width: screenWidth/2)
//                        Text("Play Again").font(.title)
//                    }.onTapGesture {
//                        gameInfo.multiChoice = false
//                    }.padding(.trailing)
//                }
//                HStack{
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.green).frame(width: screenWidth/3)
//                        Text("Easy").font(.title)
//                    }
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.yellow).frame(width: screenWidth/3)
//                        Text("Medium").font(.title)
//                    }
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.red).frame(width: screenWidth/3)
//                        Text("Hard").font(.title)
//                    }
//                }.border(.black)
                
                Picker("Choose a Mode", selection: $multiChoice){
                    ForEach(multiChoiceModes, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.segmented).colorMultiply(.green).background(.brown)
                
                Picker("Choose a difficulty", selection: $difficulty){
                    ForEach(difficulties, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.segmented).colorMultiply(.green).background(.brown)
                
                Picker("Choose a Region Mode", selection: $regionMode){
                    ForEach(regionModes, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.segmented).colorMultiply(.green).background(.brown)
                if(regionMode != "World"){
                    DropDown()
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.green)
                    VStack{
                        Text("Start").font(.title)
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
                        RoundedRectangle(cornerRadius: 5).fill(.green)
                        Text("Settings")
                    }.onTapGesture {
                        coordinator.show(Settings.self)
                    }
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(.green)
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
            }
        }
        .environmentObject(coordinator)
    }
}
