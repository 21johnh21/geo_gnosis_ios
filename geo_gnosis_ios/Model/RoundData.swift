//
//  RoundData.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/2/23.
//

import Foundation

public class RoundData{
    
    var numOfRounds = 5
    
    var multiChoiceOptions: [[Location]] = [[Location]]()
    var locationsByRegion = [Location]()
    var locations = [Location]()
    
    init(){
        load()
    }

    func load(){
        
        locationsByRegion=LocationData().locationsByRegion
        
        //choose 5 locations out of those availible
        for _ in 0...numOfRounds-1{
            let locationIndex = Int.random(in: 0..<locationsByRegion.count)
            locations.append(locationsByRegion[locationIndex])
        }
        
        //Get Multi Choice Options
        if(true){
            //var multiChoiceOptions2:
            
//            for i in 0...numOfRounds - 1{ // for every round
//                //multiChoiceOptions2[i] // init this to 4 locations
//                var roundMultiChoiceOptions = [Location]()
//                roundMultiChoiceOptions.append(locations[0])//Set the first element = to the true anser
//                for _ in 0...2{ //append 3 random locations
//                    let locationIndex = Int.random(in: 0..<locationsByRegion.count)
//                    roundMultiChoiceOptions.append(locationsByRegion[locationIndex])
//                }
//                multiChoiceOptions.append(roundMultiChoiceOptions)
//            }
            
            for i in 0...numOfRounds - 1{ // for every round
                //multiChoiceOptions2[i] // init this to 4 locations
                var roundMultiChoiceOptions = [Location]()
                roundMultiChoiceOptions.append(locations[i])
                for _ in 0...2{ //append 3 random locations
                    let locationIndex = Int.random(in: 0..<locationsByRegion.count)
                    roundMultiChoiceOptions.append(locationsByRegion[locationIndex])
                }
                multiChoiceOptions.append(roundMultiChoiceOptions)
            }
        }
        
    }
}