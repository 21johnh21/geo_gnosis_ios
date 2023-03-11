//
//  LeaderboardInfo.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/13/23.
//

import Foundation

public struct LBInfo: Codable {
    
    let userName: String?
    let finalScore: Int?
    let dateTime: Date?
    //game info vars
    let multiChoice: Bool?
    let regionMode: String?
    let difficulty: String?
    let region: String?
    //round info vars
    let times: [Int]?
    let city_ascii: [String]?
    let lat: [Double]?
    let lng: [Double]?
    let country: [String]?
    let admin_name: [String]?
    let capital: [String]?
    let population: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case userName
        case finalScore
        case dateTime
        //round info vars
        case multiChoice
        case regionMode
        case difficulty
        case region
        //game info vars
        case times
        case city_ascii
        case lat
        case lng
        case country
        case admin_name
        case capital
        case population
    }

}
