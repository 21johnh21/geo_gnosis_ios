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
                    coordinator.show(map.self)
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
            VStack{
                //probably do this programatically at some point
                HStack{
                    Text("Round 1: ").padding(.leading)
                    Spacer()
                    Text("0:00").padding(.trailing)
                }
                HStack{
                    Text("Round 2: ").padding(.leading)
                    Spacer()
                    Text("0:00").padding(.trailing)
                }
                HStack{
                    Text("Round 3: ").padding(.leading)
                    Spacer()
                    Text("0:00").padding(.trailing)
                }
                HStack{
                    Text("Round 4: ").padding(.leading)
                    Spacer()
                    Text("0:00").padding(.trailing)
                }
                HStack{
                    Text("Round 4: ").padding(.leading)
                    Spacer()
                    Text("0:00").padding(.trailing)
                }
            }
        }
    }
}

struct EndGame_Previews: PreviewProvider {
    static var previews: some View {
        EndGame()
    }
}
