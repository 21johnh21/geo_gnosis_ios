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
    var seconds = 0.0 //DELETE
    //self.timerHelper.StartTimer()
    var body: some View {
        //self.timerHelper.StartTimer()
        ZStack {
            VStack {
                MapView(coordinate:
                            CLLocationCoordinate2D(
                                latitude: 44,
                                longitude: -85)
                )
                .ignoresSafeArea(edges: .top)
                TextField("Answer...",text: $guess)
                    .onSubmit{
                        ValidateAnswer(guess: "", answer: "")
                        
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
    
    
    func ValidateAnswer (guess: String, answer: String){
        if(guess == answer){
            
            //go to next round
            //store round data
        }
        else{
            
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
