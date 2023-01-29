//
//  GameMap.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//
import SwiftUI
import CoreLocation

struct GameMap: View {
    
    //PARAMETERS
//    @State var round: Int = 0
//    var locations:  [Location] = []
    //maybe init locations in start() otherwise pass locations into the coordinator
//    @State var locations: [Location]
//    @State var round: Int
    //var timer: Timer = Timer()
    //@ObservedObject var timerHelper = TimerHelper()
    //@EnvironmentObject var gameInfo: GameInfo
    //@State var gameInfo: GameInfo
    //var location = $gameInfo.locations[$gameInfo.roundNumber]
    //var location = $gameInfo.locations[0]
    @State var guess: String = ""
    //@State var round: Int
//    let data = LocationData().locations
    //@State var locations = LocationData().locations
    @EnvironmentObject private var coordinator: Coordinator
     //Im going to need to make all these state variables parameters somehow then pass them to root view
    var seconds = 0.0 //DELETE
    //self.timerHelper.StartTimer()
    
    @EnvironmentObject var gameInfo : GameInfo
    
    //gameInfo is providing all the info I need but it returns binding values instead of normal values
    //I dont know how to fix this
    
    
    var body: some View {
        //self.timerHelper.StartTimer()
//        var locations = gameInfo.locations
//        var location = locations[0]
//        var round = $gameInfo.roundNumber
//        var lat = $gameInfo.getLat(0)
        ZStack {
            VStack {
                MapView(coordinate:
                            CLLocationCoordinate2D(
                                latitude: gameInfo.locations[gameInfo.roundNumber].lat,
                                longitude: gameInfo.locations[gameInfo.roundNumber].lng)
                )
                .ignoresSafeArea(edges: .top)
                TextField("Answer...",text: $guess)
                    .onSubmit{
                        ValidateAnswer(guess: guess, answer: gameInfo.locations[gameInfo.roundNumber].country)
                    }
                
                //.focused($emailFieldIsFocused)
                //        .onSubmit {
                //            validateAnswer(name: username)
                //        }
            }
            HStack {
                Text("R1") //Round number
                Spacer()
                //Text(String(format: "%2.f", timerHelper.seconds))
                Text(String(format: "%2.f", seconds))
                Text("0.00")
                
            }.safeAreaInset(edge: .bottom){
                
            }
        
        }
    }
    
    
    func ValidateAnswer (guess: String, answer: String) {
        if(guess == answer){
            
            if(gameInfo.roundNumber == 4){
                coordinator.show(EndGame.self)
                print("Correct!")
            }else{
                gameInfo.roundNumber += 1
                coordinator.show(GameMap.self)
                print("Correct!")
            }
        
            
            
            //go to next round
            //return EndGame()
            //store round data
         
        }
        else{
           // return map()
            //clear textField
            //send give user feed back
            //animation
            //sound
            //haptic
        }
    }
        
//    func StartTimer(){
//        var seconds = 0.0
//        var timer  = Timer()
//        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ timer in
//            seconds += 0.1
//        }
//    }
}

struct map_Previews: PreviewProvider {
    static var previews: some View {
        GameMap()
    }
}
