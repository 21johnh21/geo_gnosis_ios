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
    var locationsRaw = [Location]()
    var locationsByDif = [Location]()
    var locationsByRegion = [Location]()
    
    let difEasyPop: Int = 1000000 //1
    let difMedPop: Int = 500000 //2
    let difHardPop: Int = 0 //3
//    var difficulty: Int //get this from root eventually
    
    let regionUSA: String = "United States"
    let regionCanada: String = "Canada"
    let regionMexico: String = "Mexico"
    let regionUK: String = "United Kingdom"
//    var region: String //get this from root eventually
    
    var multiChoiceOptions: [[String]] = [[String]]()
    
    init(difficulty: String, regionMode: String, region: String){
        self.difficulty = difficulty
        self.regionMode = regionMode
        self.region = region
        load()
    }

    func load(){
        if let fileLocation = Bundle.main.url(forResource: "locationDataUpdated3", withExtension: "json"){ //create file location var
            do{
                
                let data = try Data(contentsOf: fileLocation) //try to get data from filelocation
                let jsonDecoder = JSONDecoder() // create a json decoder
                let jsonData = try jsonDecoder.decode([Location].self, from: data) //create array of objects from daata
                locationsRaw = jsonData
                
                //parse location based on difficulty
                switch(difficulty){
                case("Easy"):
                    for i in 0...locationsRaw.count-1{
                        if(locationsRaw[i].population >= difEasyPop){
                            locationsByDif.append(locationsRaw[i])
                        }
                    }
                case("Medium"):
                    for i in 0...locationsRaw.count-1{
                        if(locationsRaw[i].population >= difMedPop){
                            locationsByDif.append(locationsRaw[i])
                        }
                    }
                default: //Hard
                    locationsByDif = locationsRaw
                }
                
                
                //filter locations based on region
                if(regionMode != "World"){
                    FilterByRegion()
                }else{
                    locationsByRegion = locationsByDif
                }
            }
            catch{
                print(error)
            }
        }
    }
    
    func FilterByRegion(){
        for i in 0...locationsByDif.count-1{
            if(locationsByDif[i].country ==  region){
                locationsByRegion.append(locationsByDif[i])
            }
        }
    }
}
