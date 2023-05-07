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
    @AppStorage("userName") var userIDSt: String = ""
    
    @State var showPrivacyPolicy: Bool = false
    
    var body: some View {
        VStack{
            ZStack{
                ScrollView{
                    VStack{
                        Text("Settings").font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg))
                    }.frame(maxWidth: .infinity, minHeight: 80).background(){
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                    }
                    HStack{
                        Text(userIDSt == "" ? "Log In" : userIDSt).padding(.leading)
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .frame(width: 20.0, height: 20.0).padding().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).font(.system(size: 50, weight: .bold))
                            .shadow(radius: 7).padding()
                    }.padding().background(){
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                    }.overlay(){
                        RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
                    }
                    .onTapGesture {
                        PlayDefaultFeedback().play()
                        coordinator.show(LogIn.self)
                    }
                    VStack{
                        Slider(value: $volume, in: 0...100).tint(Color.green).padding()
                        Text("Volume \(String(format: "%.0f", volume))")
                        Divider()
                        Toggle("Vibration On", isOn: $vibOn).padding(.leading)
                        Toggle("Post Scores on leaderboard", isOn: $postScores).padding(.leading)
                        //TODO: tutorial
//                        HStack {
//                            ZStack{
//                                RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.green).frame(width: 150, height: 30)
//                                Text("Play Tutorial").padding(.leading)
//                            }.padding(.leading)
//                                .onTapGesture {
//                                    PlayDefaultFeedback().play()
//                                }
//                            Spacer()
//                        }
                        Divider()
                        VStack{
                            Text("Application Support")
                                .background(RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.green).frame(width: 215, height: 30))
                                .padding()
                                .onTapGesture {
                                    let SupportURL = "https://sites.google.com/view/geognosis/home"
                                    
                                    if let url = URL(string: SupportURL) {
                                        UIApplication.shared.open(url)
                                    }
                                }
                        }
                    }.padding().background(){
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                    }.overlay(){
                        RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
                    }
                    Spacer()
                }
                .background(alignment: .center){BackgroundView()}
            }.overlay(alignment: .bottom){
                PrivacyPolicy(showPriacyPolicy: $showPrivacyPolicy).ignoresSafeArea()
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
