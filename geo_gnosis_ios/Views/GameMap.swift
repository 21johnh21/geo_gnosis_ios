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
    @EnvironmentObject var gameInfo : GameInfo
    @State var count: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

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
                    }
                    HStack{
                        TextField("Answer...",text: $guess)
                            .onSubmit{
                                ValidateAnswer(guessB: guess, answer: gameInfo.locations[gameInfo.roundNumber].country)
                            }.padding(.leading)

                        ZStack{
                            RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 100, height: 30)
                            Text("Give Up")
                        }.onTapGesture {
                            coordinator.show(EndGame.self)
                        }
                    }
                }
            }
            HStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green)
                        .frame(width: 80, height: 30)
                    Text("Round: 1") //Round number
                }.padding(.leading)
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green)
                        .frame(width: 80, height: 30)
                    Text("\(count)").onReceive(timer){ _ in
                        count += 1
                    }
                }.padding(.trailing)
            }.safeAreaInset(edge: .bottom){
                
            }
        }
    }
    
    func ValidateAnswer (guessB: String, answer: String) {
        if(guessB == answer || guessB == ""){
            
            if(gameInfo.roundNumber == 4){
                coordinator.show(EndGame.self)
                print("Correct!")
            }else{
                gameInfo.roundNumber += 1
                coordinator.show(GameMap.self)
                print("Correct!")
            }
        }
        else{
            
            guess = "" //clear text
           // return map()
            //clear textField
            //send give user feed back
            //animation
            //sound
            //haptic
        }
    }
}

struct map_Previews: PreviewProvider {
    static var previews: some View {
        GameMap()
    }
}
