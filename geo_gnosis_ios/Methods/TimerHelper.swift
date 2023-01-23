//
//  Timer.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//

import Foundation

class TimerHelper: ObservableObject{
    @Published var seconds = 0.0
    var timer  = Timer()
    
    init(seconds: Double = 0.0, timer: Timer = Timer()) {
        self.seconds = seconds
        self.timer = timer
        self.StartTimer()
    }
    
    
    func StartTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ timer in
            self.seconds += 0.1
        }
    }
}
