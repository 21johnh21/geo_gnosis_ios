////
////  Readjson.swift
////  geo_gnosis_ios
////
////  Created by John Hawley on 1/22/23.
////
//
//import Foundation
//
//class Readjson{
//    
//    static func ReadJSONFromFile(fileName: String) -&gt; Any?
//    {
//        var json: Any?
//        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
//            do {
//                let fileUrl = URL(fileURLWithPath: path)
//                // Getting data from JSON file using the file URL
//                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
//                json = try? JSONSerialization.jsonObject(with: data)
//            } catch {
//                // Handle error here
//            }
//        }
//        return json
//    }
//}
