//
//  UserData.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/3/23.
//

import Foundation

class UserInfo: ObservableObject {
    
    @Published var userID : String = ""
    @Published var displayName : String = ""

}
