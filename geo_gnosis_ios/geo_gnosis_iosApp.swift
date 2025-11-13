//
//  geo_gnosis_iosApp.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/17/23.
//

import SwiftUI

//TODO: Clean the datafile again, try to be able to manipulate with SQL remove special chars fix country names

@main
struct geo_gnosis_iosApp: App {
    @StateObject var roundInfo = RoundInfo()
    @StateObject var gameInfo = GameInfo()
    @StateObject var timerGlobal = TimerGlobal()
    @StateObject var audioPlayer = AudioPlayer()
    @StateObject var mapTilePreloader = MapTilePreloader()

    @AppStorage("sateliteMapOn") var sateliteMapOn: Bool = true

    init() {
        // Pre-warm keyboard to reduce first-launch lag
        let _ = UITextField()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(roundInfo)
                .environmentObject(gameInfo)
                .environmentObject(timerGlobal)
                .environmentObject(audioPlayer)
                .onAppear {
                    // Start preloading map tiles in the background if satellite mode is enabled
                    mapTilePreloader.startPreloading(sateliteMapOn: sateliteMapOn)
                }
        }
    }
}
