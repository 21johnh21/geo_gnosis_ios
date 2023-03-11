//
//  LocationData.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/26/23.
//

import Foundation

public class LocationData{
    var difficulty: String
    var regionMode: String //TODO: Replace
    var region: String
    
    var numOfRounds = 5
    var locationsRaw = [Location]()
    var locationsByDif = [Location]()
    var locationsByRegion = [Location]()
    
    let difEasyPop: Int = 1000000 //1
    let difMedPop: Int = 500000 //2
    let difHardPop: Int = 0 //3
    
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

    func load(){ //TODO: Const for data file here
        if let fileLocation = Bundle.main.url(forResource: "locationDataUpdated3", withExtension: "json"){ //create file location var
            do{
                
                let data = try Data(contentsOf: fileLocation) //try to get data from filelocation
                let jsonDecoder = JSONDecoder() // create a json decoder
                let jsonData = try jsonDecoder.decode([Location].self, from: data) //create array of objects from daata
                locationsRaw = jsonData
                
                //parse location based on difficulty
                switch(difficulty){
                case(Const.modeDiffEasyText):
                    for i in 0...locationsRaw.count-1{
                        if(locationsRaw[i].population >= difEasyPop){
                            locationsByDif.append(locationsRaw[i])
                        }
                    }
                case(Const.modeDiffMedText):
                    for i in 0...locationsRaw.count-1{
                        if(locationsRaw[i].population >= difMedPop){
                            locationsByDif.append(locationsRaw[i])
                        }
                    }
                default: //Hard
                    locationsByDif = locationsRaw
                }
                
                
                //filter locations based on region
                if(regionMode != Const.modeRegCountryText){
                    //TODO: My logic may havea flaw here, should I seperate the area the user is searching in and what they are guessing by ?? 
                    FilterByRegion()
                }else{
                    locationsByRegion = locationsByDif
                    //filter this so the user doen't keep getting china
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
