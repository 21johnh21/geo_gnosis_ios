//
//  LocationData.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/26/23.
//

import Foundation
import os.log

public class LocationData{
    var difficulty: String
    var regionMode: String
    var region: String

    var numOfRounds = 5
    var locationsByRegion = [Location]()
    var loadError: String?

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "geo_gnosis_ios", category: "LocationData")

    init(difficulty: String, regionMode: String, region: String){
        self.difficulty = difficulty
        self.regionMode = regionMode
        self.region = region
        load()
    }

    func load(){
        guard let fileLocation = Bundle.main.url(forResource: Const.locationDataFile, withExtension: "json") else {
            let errorMsg = "Failed to load data from: \(Const.locationDataFile)"
            logger.error("\(errorMsg)")
            loadError = errorMsg
            return
        }

        do{
            let data = try Data(contentsOf: fileLocation)
            let jsonDecoder = JSONDecoder()
            let jsonData = try jsonDecoder.decode([Location].self, from: data)

            if jsonData.isEmpty {
                let errorMsg = "No location data available"
                logger.error("\(errorMsg)")
                loadError = errorMsg
                return
            }

            locationsByRegion = filterLocations(locations: jsonData)
            logger.info("Successfully loaded \(self.locationsByRegion.count) locations")
        }
        catch{
            let errorMsg = "Failed to decode JSON: \(error.localizedDescription)"
            logger.error("\(errorMsg)")
            loadError = errorMsg
        }
    }
    
    func filterLocations(locations: [Location]) ->[Location]{
        guard !locations.isEmpty else {
            let errorMsg = "No location data available"
            logger.error("\(errorMsg)")
            loadError = errorMsg
            return []
        }

        let filteredLocations = filterByDifficulty(locations: filterByCountry(locations: locations))
        let minimumRequired = 5 // Need at least 5 for game rounds

        if filteredLocations.count >= minimumRequired {
            logger.info("Successfully filtered \(filteredLocations.count) locations")
            return filteredLocations
        } else {
            let settings = "Difficulty: \(difficulty), Region Mode: \(regionMode), Region: \(region)"
            let errorMsg = "Not enough locations found. Found \(filteredLocations.count), need at least \(minimumRequired). Settings: \(settings)"
            logger.warning("\(errorMsg)")
            loadError = errorMsg

            // Fall back to using all locations if filtered set is too small
            if locations.count >= minimumRequired {
                logger.info("Falling back to all \(locations.count) locations")
                return locations
            } else {
                logger.error("Even unfiltered data has insufficient locations (\(locations.count))")
                return locations
            }
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
