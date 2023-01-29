//
//  EndGame.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/23/23.
//

import SwiftUI
import MapKit

struct EndGame: View {
    
    let data = LocationData().locations
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var gameInfo : GameInfo
    var round: Int = 0
    
    var body: some View {
        ScrollView {
            Text("Game Over!").padding()
            HStack {
                Text("Final Score: ").padding(.leading)
                Spacer()
                Text("0:00").padding(.trailing)
            }
            HStack{
                Button {
                    //will need to add logic here to load new data  data
                    coordinator.show(GameMap.self)
                } label: {
                    Text("Play Again")
                }.padding(.leading)
                Spacer()
                Button {
                    coordinator.popToRoot()
                } label: {
                    Text("Return to Menu")
                }.padding(.trailing)
            }
            MapView(coordinate:
                        CLLocationCoordinate2D(
                            latitude: data[0].lat,
                            longitude: data[0].lng)
            ).frame(height: 300)
            
//            ForEach() { gameInfo
//                /*@START_MENU_TOKEN@*/Text(datum.city_ascii)/*@END_MENU_TOKEN@*/
//            }
            
            ForEach(gameInfo.locations) { location in
                
                EndGameCard(
                    //round: gameInfo.roundNumber + 1 ,
                    round: 0 + 1,
                    country: gameInfo.locations[0].country,
                    state: gameInfo.locations[0].admin_name,
                    city: gameInfo.locations[0].city_ascii)
            }
                
                EndGameCard(
                    //round: gameInfo.roundNumber + 1 ,
                    round: 0 + 1,
                    country: gameInfo.locations[0].country,
                    state: gameInfo.locations[0].admin_name,
                    city: gameInfo.locations[0].city_ascii)
                
                    
        
//                ForEach(gameInfo.locations) { location in
//                    EndGameCard(
//                        round: 1,
//                        country: location.country,
//                        state: location.admin_name,
//                        city: location.city_ascii)
//                }
                
//                ForEach((0...10).reversed(), id: \.self) {
//                        Text("\($0)…")
//                    }
                
//                for i in 0...gameInfo.roundNumber {
//                    EndGameCard(round: i, country: gameInfo.locations[i].country, state:  gameInfo.locations[i].state, city: gameInfo.locations[i].city_ascii)
//                }
                

                
//                ForEach(place) { gameInfo in
//                    /*@START_MENU_TOKEN@*/Text(datum.city_ascii)/*@END_MENU_TOKEN@*/
//                }
                
                //probably do this programatically at some point
//                HStack{
//                    Text("Round 1: ").padding(.leading)
//                    Spacer()
//                    Text("0:00").padding(.trailing)
//                }
//                HStack{
//                    Text("Round 2: ").padding(.leading)
//                    Spacer()
//                    Text("0:00").padding(.trailing)
//                }
//                HStack{
//                    Text("Round 3: ").padding(.leading)
//                    Spacer()
//                    Text("0:00").padding(.trailing)
//                }
//                HStack{
//                    Text("Round 4: ").padding(.leading)
//                    Spacer()
//                    Text("0:00").padding(.trailing)
//                }
//                HStack{
//                    Text("Round 4: ").padding(.leading)
//                    Spacer()
//                    Text("0:00").padding(.trailing)
//                }
            
        }
    }
}

struct EndGame_Previews: PreviewProvider {
    static var previews: some View {
        EndGame()
    }
}
