//
//  geo_gnosis_iosApp.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/17/23.
//

import SwiftUI
//import FirebaseCore
//import FirebaseAnalytics
import Firebase
//import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    //let database = Database.database().reference()
//      var ref: DatabaseReference!
//      var ref = Database.database().reference()
    return true
  }
}

@main
struct geo_gnosis_iosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delagate
    @StateObject var roundInfo = RoundInfo()
    @StateObject var gameInfo = GameInfo()
    
//    var ref: DatabaseReference!
//
//    ref = Database.database().reference()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(roundInfo)
                .environmentObject(gameInfo)
        }
    }
}
