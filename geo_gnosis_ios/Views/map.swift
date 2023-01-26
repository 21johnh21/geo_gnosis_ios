//
//  map.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//
import SwiftUI
import CoreLocation

struct map: View {
    //var timer: Timer = Timer()
    @ObservedObject var timerHelper = TimerHelper()
    @State var guess: String = ""
    let data = LocationData2().locations
    @EnvironmentObject private var coordinator: Coordinator
    
    var seconds = 0.0 //DELETE
    //self.timerHelper.StartTimer()
    var body: some View {
        //self.timerHelper.StartTimer()
        ZStack {
            VStack {
                MapView(coordinate:
                            CLLocationCoordinate2D(
                                latitude: data[0].lat,
                                longitude: data[0].lng)
                )
                .ignoresSafeArea(edges: .top)
                TextField("Answer...",text: $guess)
                    .onSubmit{
                        ValidateAnswer(guess: guess, answer: data[0].country)
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
            coordinator.show(EndGame.self)
            print("Correct!")
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
        map()
    }
}
