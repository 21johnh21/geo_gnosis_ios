//
//  LocationData.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/26/23.
//

import Foundation

public class LocationData{
    var difficulty: String
    var regionMode: String
    var region: String
    
    var numOfRounds = 5
    var locationsByRegion = [Location]()
    
    init(difficulty: String, regionMode: String, region: String){
        self.difficulty = difficulty
        self.regionMode = regionMode
        self.region = region
        load()
    }

    func load(){
        if let fileLocation = Bundle.main.url(forResource: Const.locationDataFile, withExtension: "json"){
            do{
                
                let data = try Data(contentsOf: fileLocation) //try to get data from filelocation
                let jsonDecoder = JSONDecoder() // create a json decoder
                let jsonData = try jsonDecoder.decode([Location].self, from: data) //create array of objects from daata
                locationsByRegion = filterLocations(locations: jsonData)
            }
            catch{
                print("Error: error decoding json")
            }
        }
    }
    
    func filterLocations(locations: [Location]) ->[Location]{
        var filteredLocations = filterByDifficulty(locations: filterByCountry(locations: locations))
        if(filteredLocations.count > 4){
            print("succesfuly returned \(filteredLocations.count) locations") //TODO: Delete
            return filterByDifficulty(locations: filterByCountry(locations: locations))
        }else{
            let error = "Error: error filtering locations only \(filteredLocations.count) returned for Game Settings - Diff: \(difficulty), Reg Mode: \(regionMode), Region: \(region)"
            print(error)
            return locations
        }
    }
    func filterByCountry(locations: [Location]) ->[Location]{
        var filteredLocations = [Location]()
        if(region == Const.modeRegCountryText){
            return locations
        }

        for i in 0...locations.count-1{
            if(locations[i].country ==  region){
                filteredLocations.append(locations[i])
            }
        }
        return filteredLocations
    }
    func filterByDifficulty(locations: [Location]) ->[Location]{
        if(difficulty == Const.modeDiffHardText){
            return locations
        }

        var sortedLocations = [Location]()
        sortedLocations = sortByPopulation(locations, population: \.population)
        let percentOfLocationsToUse: Double = (difficulty == Const.modeDiffEasyText) ? 0.1 : 0.4

        //TODO: more logic should be added to this, 20% in the USA is a lot different from 20% in guatemala, should also consider if smaller countries actually have enough locations to return this percentage. Do some math to determine what the percentage should be. actually for the USA 20% seems really high I still end up with a lot of obscure suburbs and smaller towns
        let numberOfLocationsToUse: Int = Int(Double(locations.count) * percentOfLocationsToUse)

        if(difficulty == Const.modeDiffEasyText){
            return  Array(sortedLocations.prefix((numberOfLocationsToUse > 500) ? 500 : numberOfLocationsToUse))
        }

        return  Array(sortedLocations.prefix((numberOfLocationsToUse > 1000) ? 1000 : numberOfLocationsToUse))

    }
    func sortByPopulation(_ locations: [Location], population: KeyPath<Location, Int>) -> [Location] {
        return locations.sorted { $0[keyPath: population] > $1[keyPath: population] }
    }
}
