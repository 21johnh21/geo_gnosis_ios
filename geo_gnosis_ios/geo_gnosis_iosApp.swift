//
//  geo_gnosis_iosApp.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/17/23.
//

import SwiftUI

@main
struct geo_gnosis_iosApp: App {
    @StateObject var gameInfo = GameInfo()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(gameInfo)
        }
    }
}
