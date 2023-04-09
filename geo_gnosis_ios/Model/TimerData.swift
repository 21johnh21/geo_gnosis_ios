//
//  TimerData.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/28/23.
//

import Foundation

class TimerGlobal: ObservableObject {
    @Published var timerGlobal = Const.maxRoundScoreValue
    @Published var penalty = false
    @Published var showSetUp = false
}
