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
    
    @State var showPrivacyPolicy: Bool = false
    
    var body: some View {
        VStack{
            ZStack{
                ScrollView{
                    VStack{
                        Text("Settings").font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg))
                    }.frame(maxWidth: .infinity).background(){
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                    }
                    HStack{
                        Text("Log In").padding(.leading)//either say login or thier user name here
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .frame(width: 20.0, height: 20.0).padding().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).font(.system(size: 50, weight: .bold))
                            .shadow(radius: 7).padding()
                            .onTapGesture {
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
                                coordinator.show(LogIn.self)
                            }
                    }.padding().background(){
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                    }.overlay(){
                        RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
                    }
                    VStack{
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
                                    if(vibOn){
                                        let generator = UIImpactFeedbackGenerator(style: .light)
                                        generator.impactOccurred()
                                    }
                                }
                            Spacer()
                        }
                        VStack{
                            Text("Questions, Comments, Concerns?")
                            Text("Please reaach out to me with any issues you have with the app. I'd also love to hear about any ways the app could be improved. Thanks for playing!")
                            HStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.green).frame(width: 150, height: 30)
                                    Text("Contact Dev").padding(.leading)
                                }.padding(.leading)
                                    .onTapGesture {
                                        if(vibOn){
                                            let generator = UIImpactFeedbackGenerator(style: .light)
                                            generator.impactOccurred()
                                        }
                                        if let url = URL(string: "mailto:\(Const.email)") {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                                Spacer()
                            }
                        }
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.green).frame(width: 150, height: 30)
                                Text("Privacy Policy").padding(.leading)
                            }.padding(.leading)
                                .onTapGesture {
                                    if(vibOn){
                                        let generator = UIImpactFeedbackGenerator(style: .light)
                                        generator.impactOccurred()
                                    }
                                    showPrivacyPolicy.toggle()
                                }
                            Spacer()
                        }
                    }.padding().background(){
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                    }.overlay(){
                        RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
                    }
                    Spacer()
                }//.background(CustomColor.secondary)
                .background(alignment: .center){BackgroundView()}
            }.overlay(alignment: .bottom){
                PrivacyPolicy(showPriacyPolicy: $showPrivacyPolicy).ignoresSafeArea()
            }//.ignoresSafeArea()
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
