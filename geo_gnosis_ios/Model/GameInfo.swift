//
//  GameInfo.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/28/23.
//

import Foundation

class GameInfo: ObservableObject{
    
    @Published var locations = [Location]()
    @Published var roundNumber = 0
    //timer
    
    func getLat(lat: Double) -> Double{
        return locations[0].lat
    }
}
