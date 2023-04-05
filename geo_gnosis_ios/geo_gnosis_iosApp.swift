//
//  geo_gnosis_iosApp.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/17/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

//TODO: Clean the datafile again, try to be able to manipulate with SQL remove special chars fix country names

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      Auth.auth()
      return true
  }
}

@main
struct geo_gnosis_iosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delagate
    @StateObject var roundInfo = RoundInfo()
    @StateObject var gameInfo = GameInfo()
    @StateObject var timerGlobal = TimerGlobal()
    @StateObject var audioPlayer = AudioPlayer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(roundInfo)
                .environmentObject(gameInfo)
                .environmentObject(timerGlobal)
                .environmentObject(audioPlayer)
        }
    }
}
