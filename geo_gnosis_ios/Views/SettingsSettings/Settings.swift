//
//  Settings.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/7/23.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject private var coordinator: Coordinator
    @AppStorage("vibOn") var vibOn: Bool = true
    @AppStorage("sound") var sound: Double = 100
    @AppStorage("sateliteMapOn") var sateliteMapOn: Bool = false
    @AppStorage("loggedIn") var loggedIn: Bool = false
    @AppStorage("darkMode") var darkMode: Bool = false
    @AppStorage("postScores") var postScores: Bool = true
    
    var body: some View {
        VStack{
            Text("Geo Gnosis").font(.title)
            HStack{
                Text("Log In")//either say login or thier user name here
                Spacer()
                Image("defaultProfile").resizable()
                    .frame(width: 20.0, height: 20.0).padding().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay {
                        Circle().stroke(.black, lineWidth: 4)
                    }
                    .shadow(radius: 7).padding()
                    .onTapGesture {
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                        coordinator.show(LogIn.self)
                    }
                    //.frame(width: 20.0, height: 20.0).padding()
                    
            }
            Toggle("Vibration On", isOn: $vibOn)
            Slider(value: $sound, in: 0...100).tint(Color.green).padding()
            //var soundText = String(format: "%.0f", sound)
            Text("Volume \(String(format: "%.0f", sound))")
                //Slider()
            Toggle("Satelite Map Mode", isOn: $sateliteMapOn)
            Toggle("Post Scores on leaderboard", isOn: $postScores)
            Toggle("Dark Mode", isOn: $darkMode)
            HStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.green).frame(width: 150, height: 30)
                    Text("Play Tutorial")
                }.onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                }
                Spacer()
            }
            Spacer()
        }//.background(CustomColor.secondary)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
