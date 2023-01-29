//
//  GameMap.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//
import SwiftUI
import CoreLocation

struct GameMap: View {
    
    @State var guess: String = ""
    @EnvironmentObject private var coordinator: Coordinator
    var seconds = 0.0 //DELETE
    @EnvironmentObject var gameInfo : GameInfo
    
    var body: some View {
        ZStack {
            VStack {
                MapView(coordinate:
                            CLLocationCoordinate2D(
                                latitude: gameInfo.locations[gameInfo.roundNumber].lat,
                                longitude: gameInfo.locations[gameInfo.roundNumber].lng)
                )
                .ignoresSafeArea(edges: .top)
                
                VStack{
                    HStack{
                        Spacer()
//                        ZStack{
//                            RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 100, height: 30)
//                            Text("Give Up")
//                        }
                    }
                    HStack{
                        TextField("Answer...",text: $guess)
                            .onSubmit{
                                ValidateAnswer(guess: guess, answer: gameInfo.locations[gameInfo.roundNumber].country)
                            }.padding(.leading)
                        ZStack{
                            RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 100, height: 30)
                            Text("Give Up")
                        }.onTapGesture {
                            coordinator.popToRoot()
                        }
                    }
                }
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
