//
//  Constants.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/9/23.
//

import Foundation

/*
 Access like:
 Const.modeDiffEasy
 */

struct Const{
    static let modeDiffEasy = 1
    static let modeDiffMed = 2
    static let modeDiffHard = 3
    
    static let modeRegCountry = 1
    static let modeRegRegion = 2
    static let modeRegCity = 3
    
    //Should probably add text values for these  ^ as well
    
    static let dbScoreCollection = "Score Collection"
    
    static let fontNormalText = "Changa-Light"
    static let fontTitle = "BebasNeue-Regular"
    static let fontSizeNormStd = 16.0
    static let fontSizeNormLrg = 40.0
    static let fontSizeTitleLrg = 45.0
    static let fontSizeTitleSm = 20.0
    
    static let audioActionBackground = "action-sound-effect"
    static let audioCorrectEffect = "Ding-sound-effect"
    static let audioIncorrectEffect = "button-click-sound-effect"
    
    //Image values
    
    
    static let maxFinalScoreValue = 500
    static let maxRoundScoreValue = 100
    
    static let numOfRounds = 5
}
