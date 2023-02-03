//
//  GameInfo.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/28/23.
//

import Foundation

class RoundInfo: ObservableObject, Identifiable{
    
    //This will be for arrays with data associated with each round
    
    @Published var locations = [Location]()
    @Published var roundNumber = 0 //move this over to GameInfo
    @Published var times = [Int]()
    @Published var roundNumbers = [Int]()
    @Published var answers = [Bool]()
    @Published var multiChoiceOptions = [[Location]]() //2 dim array stores 4 options each 
}
