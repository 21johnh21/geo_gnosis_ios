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
    @AppStorage("darkMode") var darkMode: Bool = false

    @State var showPrivacyPolicy: Bool = false
    
    var body: some View {
        VStack{
            ZStack{
                ScrollView{
                    // Header
                    VStack{
                        Text("Settings")
                            .font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg))
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(){
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                    }
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

                    // Settings Content
                    VStack(spacing: 20){
                        // Audio Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Audio")
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                .fontWeight(.semibold)

                            VStack(spacing: 8) {
                                HStack {
                                    Text("Volume")
                                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                    Spacer()
                                    Text("\(String(format: "%.0f", volume))%")
                                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                        .foregroundColor(.gray)
                                }
                                Slider(value: $volume, in: 0...100)
                                    .tint(Color.green)
                            }
                        }

                        Divider()
                            .background(CustomColor.trim2)

                        // Haptics Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Haptics")
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                .fontWeight(.semibold)

                            Toggle("Vibration", isOn: $vibOn)
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                        }

                        Divider()
                            .background(CustomColor.trim2)

                        // Support Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Support")
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                .fontWeight(.semibold)

                            Button(action: {
                                let SupportURL = "https://sites.google.com/view/geognosis/home"
                                if let url = URL(string: SupportURL) {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                HStack {
                                    Text("Application Support")
                                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    Spacer()
                                    Image(systemName: "arrow.up.right.square")
                                        .font(.system(size: 16))
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.green.opacity(0.9))
                                )
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                            }
                        }
                    }
                    .padding(20)
                    .background(){
                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                    }
                    .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
                    .padding(.top, 8)

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
