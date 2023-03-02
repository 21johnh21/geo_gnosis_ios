//
//  RoundInfo.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/31/23.
//

import Foundation

class GameInfo: ObservableObject {
    @Published var multiChoice = false
    @Published var regionMode = "World"
    @Published var difficulty = "Easy"
    @Published var region = "World"
    //round number
    
//    public struct GameInfo: Codable{
//        
//        
//        var multiChoice = false
//        var regionMode = "World"
//        var difficulty = "Easy"
//        var region = "World"
//        
//        enum CodingKeys: String, CodingKey {
//            case multiChoice
//            case regionMode
//            case difficulty
//            case region 
//        }
//    }
}
