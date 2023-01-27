////
////  LocationData2.swift
////  geo_gnosis_ios
////
////  Created by John Hawley on 1/22/23.
////
//
//import Foundation
//
//public class LocationData2{
//    @Published var locations = [Location]()
//    
//    init(){
//        load()
//    }
//    
//    func load(){
//        if let fileLocation = Bundle.main.url(forResource: "sampleLocationData", withExtension: "json"){ //create file location var
//            do{
//                let data = try Data(contentsOf: fileLocation) //try to get data from filelocation
//                let jsonDecoder = JSONDecoder() // create a json decoder
//                let jsonData = try jsonDecoder.decode([Location].self, from: data) //create array of objects from daata
//                self.locations = jsonData
//            }
//            catch{
//                print(error)
//            }
//        }
//    }
//}
