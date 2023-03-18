//
//  RoundData.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/2/23.
//

import Foundation

public class RoundData{
    
    var multiChoice: Bool
    var difficulty: String
    var regionMode: String
    var region: String
    
    var numOfRounds = 5
    var multiChoiceOptions: [[Location]] = [[Location]]()
    var locationsByRegion = [Location]()
    var locations = [Location]()
    var usedCountries: [String] = [String]()
    var count: Int = 0
    
    init(multiChoice: Bool, difficulty: String, regionMode: String, region: String){
        self.multiChoice = multiChoice
        self.difficulty = difficulty
        self.regionMode = regionMode
        self.region = region
        load()
    }

    func load(){
        
        //TODO: this filtering should be refactored
        
        locationsByRegion=LocationData(difficulty: difficulty, regionMode: regionMode, region: region).locationsByRegion
        
        //choose 5 locations out of those availible
        if(regionMode != Const.modeRegCountryText){
            for _ in 0...numOfRounds-1{
                let locationIndex = Int.random(in: 0..<locationsByRegion.count)
                locations.append(locationsByRegion[locationIndex])
            }
        }else{ //if its world mode prevent locations from the same country
            while(count < numOfRounds){
                let locationIndex = Int.random(in: 0..<locationsByRegion.count)
                if(!(usedCountries.contains(locationsByRegion[locationIndex].country))){
                    locations.append(locationsByRegion[locationIndex])
                    usedCountries.append(locations[count].country)
                    count = count + 1
                }
            }
        }
        
        //Get Multi Choice Options
        if(multiChoice && locationsByRegion.count != 0){
            for i in 0...numOfRounds - 1{ // for every round
                var roundMultiChoiceOptionCountries: [String] = [String]()
                var roundMultiChoiceOptions = [Location]()
                roundMultiChoiceOptions.append(locations[i])
                roundMultiChoiceOptionCountries.append(locations[i].country)
                for _ in 0...2{ //append 3 random locations
                    var locationIndex = Int.random(in: 0..<locationsByRegion.count)
                    if(regionMode == Const.modeRegCountryText){
                        var locationChosen: Bool = false
                        var count: Int = 0
                        while(!locationChosen){
                            
                            let countryUsed: Bool = roundMultiChoiceOptionCountries.contains(locationsByRegion[locationIndex].country)
                            
                            if(!countryUsed){ // if the country has nott been used yet
                                roundMultiChoiceOptionCountries.append(locationsByRegion[locationIndex].country)
                                roundMultiChoiceOptions.append(locationsByRegion[locationIndex])
                                locationChosen = true
                            }else{
                                locationIndex = Int.random(in: 0..<locationsByRegion.count)
                                count = count + 1
                            }
                        }
                    }else{
                        roundMultiChoiceOptions.append(locationsByRegion[locationIndex])
                    }
                }
                multiChoiceOptions.append(roundMultiChoiceOptions)
            }
        }
    }
}
