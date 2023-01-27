//
//  Location.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//

import Foundation
import CoreLocation

struct Location: Codable {
    
    var city_ascii : String
    var lat : Double
    var lng : Double
    var country: String
    var admin_name : String
    var capital : String // change to bool somehow
    var population : Int
}
