//
//  LBData.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/5/23.
//

import Foundation

struct LBData: Identifiable, Codable{
    
    var id = UUID()
    var admin_name: [String]
    var capital: [String]
    var city_ascii: [String]
    var country: [String]
    var dateTime: String
    var difficulty: String
    var finalScore: Int
    var lat: [Double]
    var lng: [Double]
    var multiChoice: Bool
    var population: [Int]
    var region: String
    var regionMode: String
    var times: [Int]
    var userName: String
    
    enum CodingKeys: String, CodingKey{
        case admin_name
        case capital
        case city_ascii
        case country
        case dateTime
        case difficulty
        case finalScore
        case lat
        case lng
        case multiChoice
        case population
        case region
        case regionMode
        case times
        case userName
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        print("\(container)")
        self.admin_name = try container.decode([String].self, forKey: .admin_name)
        self.capital = try container.decode([String].self, forKey: .capital)
        self.city_ascii = try container.decode([String].self, forKey: .city_ascii)
        self.country = try container.decode([String].self, forKey: .country)
        self.dateTime = try container.decode(String.self, forKey: .dateTime)
        self.difficulty = try container.decode(String.self, forKey: .difficulty)
        self.finalScore = try container.decode(Int.self, forKey: .finalScore)
        self.lat = try container.decode([Double].self, forKey: .lat)
        self.lng = try container.decode([Double].self, forKey: .lng)
        self.multiChoice = try container.decode(Bool.self, forKey: .multiChoice)
        self.population = try container.decode([Int].self, forKey: .population)
        self.region = try container.decode(String.self, forKey: .region)
        self.regionMode = try container.decode(String.self, forKey: .regionMode)
        self.times = try container.decode([Int].self, forKey: .times)
        self.userName = try container.decode(String.self, forKey: .userName)
        print("LBData: \(self)")
    }
}
