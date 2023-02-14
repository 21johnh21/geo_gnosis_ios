//
//  LeaderboardInfo.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/13/23.
//

import Foundation

struct LeaderboardInfo{
    
    var userName: String
    var finalScore: Int
    var gameInfo: GameInfo
    var roundInfo: [RoundInfo] //array of all round information for each of the rounds 
}
