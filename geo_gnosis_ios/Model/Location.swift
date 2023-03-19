//
//  Location.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Decodable{
    
    let id = UUID()
    var city_ascii : String
    var lat : Double
    var lng : Double
    var country: String
    var admin_name : String
    var capital : String
    var population : Int
    
    
    init(id: ObjectIdentifier, city_ascii: String, lat: Double, lng: Double, country: String, admin_name: String, capital: String, population: Int) {
        self.city_ascii = city_ascii
        self.lat = lat
        self.lng = lng
        self.country = country
        self.admin_name = admin_name
        self.capital = capital
        self.population = population
    }
    
    enum CodingKeys: Int, CodingKey {
        case id, city_ascii, lat, lng, country, admin_name, capital, population
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city_ascii = try values.decode(String.self, forKey: .city_ascii)
        lat = try values.decode(Double.self, forKey: .lat)
        lng = try values.decode(Double.self, forKey: .lng)
        country = try values.decode(String.self, forKey: .country)
        admin_name = try values.decode(String.self, forKey: .admin_name)
        capital = try values.decode(String.self, forKey: .capital)
        population = try values.decode(Int.self, forKey: .population)
    }
}

