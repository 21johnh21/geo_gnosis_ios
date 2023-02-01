//
//  LocationData.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/26/23.
//

import Foundation

public class LocationData{
    
    var numOfRounds = 5
    var locationsRaw = [Location]()
    var locationsByDif = [Location]()
    var locationsByRegion = [Location]()
    var locations = [Location]()
    //var multiChoiceOptions = [[String]]()
    
    let difEasyPop: Int = 1000000 //1
    let difMedPop: Int = 500000 //2
    let difHardPop: Int = 0 //3
    var difficulty: Int = 0 //get this from root eventually
    
    let regionUSA: String = "United States"
    let regionCanada: String = "Canada"
    let regionMexico: String = "Mexico"
    let regionUK: String = "United Kingdom"
    var region: String = "World"  //get this from root eventually
    
    var multiChoice: Bool //set this from root eventually //but how this data needs to be passed in
    var multiChoiceOptions: [String]
    
    init(multiChoice: Bool, multiChoiceOptions: [String]){
        self.multiChoice = multiChoice
        self.multiChoiceOptions = multiChoiceOptions
        load()
    }
    
//    init(multiChoice: Bool){
//        self.multiChoice = multiChoice
//        load()
//    }

    func load(){
        if let fileLocation = Bundle.main.url(forResource: "sampleLocationData2", withExtension: "json"){ //create file location var
            do{
                
                let data = try Data(contentsOf: fileLocation) //try to get data from filelocation
                let jsonDecoder = JSONDecoder() // create a json decoder
                let jsonData = try jsonDecoder.decode([Location].self, from: data) //create array of objects from daata
                //self.locations = jsonData //array of all locations
                locationsRaw = jsonData
                
                //parse location based on difficulty
                switch(difficulty){
                case(1):
                    for i in 0...locationsRaw.count{
                        if(locationsRaw[i].population >= difEasyPop){
                            locationsByDif.append(locationsRaw[i])
                        }
                    }
                case(2):
                    for i in 0...locationsRaw.count{
                        if(locationsRaw[i].population >= difMedPop){
                            locationsByDif.append(locationsRaw[i])
                        }
                    }
                default:
                    locationsByDif = locationsRaw
                }
                
                
                //filter locations based on region
                if(region != "World"){
                    FilterByRegion()
                }else{
                    locationsByRegion = locationsByDif
                }
                
                //choose 5 locations out of those availible
                for _ in 0...numOfRounds-1{
                    let locationIndex = Int.random(in: 0..<locationsByRegion.count)
                    locations.append(locationsByRegion[locationIndex])
                }
                
                //Get Multi Choice Options
                if(multiChoice == true){
                    for _ in 0...((numOfRounds*4)-1){
                        let locationIndex = Int.random(in: 0..<locationsByRegion.count)
                        multiChoiceOptions.append(locationsByRegion[locationIndex].country) //how to pass this out of class
                    }
                }
                
            }
            catch{
                print(error)
            }
        }
    }
    
    func FilterByRegion(){
        for i in 0...locationsByDif.count{
            if(locationsByDif[i].country ==  region){
                locationsByRegion.append(locationsByDif[i])
            }
        }
    }
}
