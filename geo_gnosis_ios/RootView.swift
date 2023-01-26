//
//  RootView.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/25/23.
//

import Foundation
import SwiftUI

struct RootView: View {
    @StateObject private var coordinator = Coordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                Button {
                    coordinator.show(start.self)
                } label: {
                    Text("Show View A")
                }
                Button {
                    coordinator.show(map.self)
                } label: {
                    Text("Show View B")
                }
            }
            .navigationDestination(for: String.self) { id in
                if id == String(describing: start.self) {
                    start()
                } else if id == String(describing: map.self) {
                    map()
                }
                else if id == String(describing: EndGame.self){
                    EndGame()
                }
//                else if id == String(describing: RootView.self){
//                    RootView()
//                }
                else{
                    
                }
                
                
//                switch(id){
//                case (String(describing: start.self)):
//                    start()
//                case (String(describing: start.self)):
//                    map()
//                case (String(describing: start.self)):
//                    EndGame()
//                default (String(describing: start.self)):
//                    RootView()
//
//                }
            }
        }
        .environmentObject(coordinator)
    }
}
