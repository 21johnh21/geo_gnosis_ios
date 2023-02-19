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
        
        locationsByRegion=LocationData(difficulty: difficulty, regionMode: region, region: region).locationsByRegion
        
        //choose 5 locations out of those availible
        if(regionMode != "World"){
            for _ in 0...numOfRounds-1{
                let locationIndex = Int.random(in: 0..<locationsByRegion.count)
                locations.append(locationsByRegion[locationIndex])
            }
        }else{ //if its world mode prevent locations from the same country
            //for i in 0...numOfRounds-1{
            while(count < numOfRounds){
                let locationIndex = Int.random(in: 0..<locationsByRegion.count)
                if(usedCountries.contains(locationsByRegion[locationIndex].country)){
//                    locations.append(locationsByRegion[locationIndex])
//                    usedCountries.append(locations[i].country)
                }else{
                    locations.append(locationsByRegion[locationIndex])
                    usedCountries.append(locations[count].country)
                    count = count + 1
                }
            }
        }
        
        //Get Multi Choice Options
        if(multiChoice && locationsByRegion.count != 0){
            for i in 0...numOfRounds - 1{ // for every round
                //multiChoiceOptions2[i] // init this to 4 locations
                var roundMultiChoiceOptions = [Location]()
                roundMultiChoiceOptions.append(locations[i])
                for _ in 0...2{ //append 3 random locations
                    var locationIndex = Int.random(in: 0..<locationsByRegion.count)
                    //roundMultiChoiceOptions.append(locationsByRegion[locationIndex])
                    //if this locations country is not = to the correct locations country
                    if(regionMode == "World" ){
                        var locationChosen: Bool = false
                        var count: Int = 0
                        while(!locationChosen){
                            if(locationsByRegion[locationIndex].country != roundMultiChoiceOptions[0].country){
                                roundMultiChoiceOptions.append(locationsByRegion[locationIndex])
                                locationChosen = true
                            }else{
                                //TODO: Maybe log error here somehow
                                locationIndex = Int.random(in: 0..<locationsByRegion.count)
                                count = count + 1
                                print(count)
                            }
                        }
                    }else{
                        roundMultiChoiceOptions.append(locationsByRegion[locationIndex])
                    }
//                    let locationIndex = Int.random(in: 0..<locationsByRegion.count)
//                    roundMultiChoiceOptions.append(locationsByRegion[locationIndex])
                    //------
                }
                multiChoiceOptions.append(roundMultiChoiceOptions)
            }
        }
    }
}
