//
//  RoundInfo.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/31/23.
//

import Foundation

class GameInfo: ObservableObject {
    @Published var multiChoice = false
    @Published var regionMode = Const.modeRegCountry
    @Published var difficulty: Int = Const.modeDiffEasy
    @Published var region = "World"
}
