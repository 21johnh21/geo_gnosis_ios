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
                    ZStack{
                        RoundedRectangle(cornerRadius: 8, style: .continuous).fill(CustomColor.primary).frame(height: 80)
                        Text("Settings")
                            .font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg))
                            .padding(.top)
                    }

                    // Settings Content
                    VStack(spacing: 12){
                        // Audio Section
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 6) {
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.system(size: Const.fontSizeNormStd - 2))
                                    .foregroundColor(.gray)
                                Text("Audio")
                                    .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    .fontWeight(.semibold)
                            }

                            VStack(spacing: 8) {
                                HStack {
                                    Text("Volume")
                                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text("\(String(format: "%.0f", volume))%")
                                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                        .foregroundColor(.gray)
                                }
                                Slider(value: $volume, in: 0...100)
                                    .tint(CustomColor.secondary)
                            }
                        }
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(CustomColor.primary)
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                        )

                        // Haptics Section
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 6) {
                                Image(systemName: "waveform")
                                    .font(.system(size: Const.fontSizeNormStd - 2))
                                    .foregroundColor(.gray)
                                Text("Haptics")
                                    .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    .fontWeight(.semibold)
                            }

                            HStack(spacing: 8) {
                                Button(action: {
                                    PlayDefaultFeedback().play()
                                    vibOn = true
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "waveform")
                                            .font(.system(size: Const.fontSizeNormStd - 4))
                                        Text("On")
                                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                                            .fill(vibOn ? CustomColor.secondary : CustomColor.trim)
                                    )
                                    .foregroundColor(vibOn ? .primary : .secondary)
                                }

                                Button(action: {
                                    vibOn = false
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "waveform.slash")
                                            .font(.system(size: Const.fontSizeNormStd - 4))
                                        Text("Off")
                                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                                            .fill(!vibOn ? CustomColor.secondary : CustomColor.trim)
                                    )
                                    .foregroundColor(!vibOn ? .primary : .secondary)
                                }
                            }
                        }
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(CustomColor.primary)
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                        )

                        // Support Section
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 6) {
                                Image(systemName: "questionmark.circle.fill")
                                    .font(.system(size: Const.fontSizeNormStd - 2))
                                    .foregroundColor(.gray)
                                Text("Support")
                                    .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    .fontWeight(.semibold)
                            }

                            Button(action: {
                                PlayDefaultFeedback().play()
                                let SupportURL = "https://sites.google.com/view/geognosis/home"
                                if let url = URL(string: SupportURL) {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                HStack {
                                    Image(systemName: "link")
                                        .font(.system(size: Const.fontSizeNormStd - 2))
                                    Text("Application Support")
                                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                        .font(.system(size: Const.fontSizeNormStd - 4))
                                }
                                .padding(12)
                                .background(
                                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                                        .fill(CustomColor.secondary)
                                )
                                .foregroundColor(.primary)
                            }
                        }
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(CustomColor.primary)
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                        )
                    }
                    .padding(16)

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
