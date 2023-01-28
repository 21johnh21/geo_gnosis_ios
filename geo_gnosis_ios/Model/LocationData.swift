//
//  LocationData.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/26/23.
//

import Foundation

public class LocationData{
    var numOfRounds = 5
    var locationsTemp = [Location]()
    @Published var locations = [Location]()
    //@Published var locations = [Location](count: numOfRounds, repeatedValue:0 )
    
    //var someInts = [Int](count: 3, repeatedValue: 0)// this doesnt work
    //var someInts = (count: 3, repeatedValue: 0)//this does
    
    init(){
        load()
    }
    
    func load(){
        if let fileLocation = Bundle.main.url(forResource: "sampleLocationData2", withExtension: "json"){ //create file location var
            do{
                let data = try Data(contentsOf: fileLocation) //try to get data from filelocation
                let jsonDecoder = JSONDecoder() // create a json decoder
                let jsonData = try jsonDecoder.decode([Location].self, from: data) //create array of objects from daata
                //self.locations = jsonData //array of all locations
                locationsTemp = jsonData
                
                //parse location based on difficulty
                
                //filter locations based on game mode
                
                //choose 5 locations out of those availible
                
                //This works, its only broken because locations isnt initialized to have 5 valeus
                // maybe try appending to locations instead ??
                
                for _ in 0...numOfRounds-1{
                    let locationIndex = Int.random(in: 0..<locationsTemp.count)
                    locations.append(locationsTemp[locationIndex])
                }
            }
            catch{
                print(error)
            }
        }
    }
}
