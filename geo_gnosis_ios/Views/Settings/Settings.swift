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
    @AppStorage("volume") var volume: Double = 100
    @AppStorage("sateliteMapOn") var sateliteMapOn: Bool = false
    @AppStorage("loggedIn") var loggedIn: Bool = false
    @AppStorage("darkMode") var darkMode: Bool = false
    @AppStorage("postScores") var postScores: Bool = true
    
    var body: some View {
        VStack{
            VStack{
                Text("Settings").font(.custom("BebasNeue-Regular", size: 45))
            }.frame(maxWidth: .infinity).background(){
                RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
            }
            HStack{
                Text("Log In").padding(.leading)//either say login or thier user name here
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
            }
            Toggle("Vibration On", isOn: $vibOn).padding(.leading)
            Slider(value: $volume, in: 0...100).tint(Color.green).padding()
            Text("Volume \(String(format: "%.0f", volume))")
            Toggle("Satelite Map Mode", isOn: $sateliteMapOn).padding(.leading)
            Toggle("Post Scores on leaderboard", isOn: $postScores).padding(.leading)
            Toggle("Dark Mode", isOn: $darkMode).padding(.leading)
            HStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.green).frame(width: 150, height: 30)
                    Text("Play Tutorial").padding(.leading)
                }.padding(.leading)
                .onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                }
                Spacer()
            }
            Spacer()
        }.background(CustomColor.secondary)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
