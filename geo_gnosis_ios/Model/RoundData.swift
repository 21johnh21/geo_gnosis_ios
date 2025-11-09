//
//  RoundData.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/2/23.
//

import Foundation
import os.log

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

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "geo_gnosis_ios", category: "RoundData")

    init(multiChoice: Bool, difficulty: String, regionMode: String, region: String){
        self.multiChoice = multiChoice
        self.difficulty = difficulty
        self.regionMode = regionMode
        self.region = region
        load()
    }

    func load(){

        locationsByRegion = LocationData(difficulty: difficulty, regionMode: regionMode, region: region).locationsByRegion

        // Guard against empty location data
        guard !locationsByRegion.isEmpty else {
            logger.error("No locations available to load")
            return
        }

        if locationsByRegion.count < numOfRounds {
            logger.warning("Insufficient locations (\(self.locationsByRegion.count)) for \(self.numOfRounds) rounds. Using available locations with duplicates.")
        }

        //choose 5 locations out of those available
        if(regionMode != Const.modeRegCountryText){
            for _ in 0...numOfRounds-1{
                let locationIndex = Int.random(in: 0..<locationsByRegion.count)
                locations.append(locationsByRegion[locationIndex])
            }
        }else{ //if its world mode prevent locations from the same country
            let maxAttempts = locationsByRegion.count * 2 // Prevent infinite loops
            var attempts = 0

            while(count < numOfRounds && attempts < maxAttempts){
                let locationIndex = Int.random(in: 0..<locationsByRegion.count)
                if(!(usedCountries.contains(locationsByRegion[locationIndex].country))){
                    locations.append(locationsByRegion[locationIndex])
                    usedCountries.append(locations[count].country)
                    count = count + 1
                }
                attempts += 1
            }

            // If we couldn't get enough unique countries, fill with duplicates
            if count < numOfRounds {
                logger.warning("Could not find \(self.numOfRounds) unique countries. Found \(self.count). Filling remaining with duplicates.")
                while count < numOfRounds {
                    let locationIndex = Int.random(in: 0..<locationsByRegion.count)
                    locations.append(locationsByRegion[locationIndex])
                    count += 1
                }
            }
        }
        
        //Get Multi Choice Options
        if(multiChoice && !locationsByRegion.isEmpty && !locations.isEmpty){
            // Ensure we have enough locations for the game
            guard locations.count >= numOfRounds else {
                logger.error("Insufficient locations loaded for multiple choice options")
                return
            }

            for i in 0...numOfRounds - 1{ // for every round
                var roundMultiChoiceOptionCountries: [String] = [String]()
                var roundMultiChoiceOptions = [Location]()
                roundMultiChoiceOptions.append(locations[i])
                roundMultiChoiceOptionCountries.append(locations[i].country)

                for _ in 0...2{ //append 3 random locations
                    var locationIndex = Int.random(in: 0..<locationsByRegion.count)
                    if(regionMode == Const.modeRegCountryText){
                        var locationChosen: Bool = false
                        let maxAttempts = 100 // Prevent infinite loop
                        var attempts: Int = 0

                        while(!locationChosen && attempts < maxAttempts){
                            let countryUsed: Bool = roundMultiChoiceOptionCountries.contains(locationsByRegion[locationIndex].country)

                            if(!countryUsed){ // if the country has not been used yet
                                roundMultiChoiceOptionCountries.append(locationsByRegion[locationIndex].country)
                                roundMultiChoiceOptions.append(locationsByRegion[locationIndex])
                                locationChosen = true
                            }else{
                                locationIndex = Int.random(in: 0..<locationsByRegion.count)
                                attempts = attempts + 1
                            }
                        }

                        // If we couldn't find a unique country, just add any location
                        if !locationChosen {
                            logger.warning("Could not find unique country for multiple choice option. Using duplicate.")
                            roundMultiChoiceOptions.append(locationsByRegion[locationIndex])
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
