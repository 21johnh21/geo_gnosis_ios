//
//  ViewAssets.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/18/23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [CustomColor.backgrad1, CustomColor.secondary]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
    }
}

struct PlayDefaultFeedback {
    @AppStorage("vibOn") var vibOn: Bool = true
    
    let generator = UIImpactFeedbackGenerator(style: .light)
    func play(){
        if(vibOn){
            generator.impactOccurred()
        }
    }
}

struct StdText: View {
    @State var textIn: String
    var body: some View {
        //@State var textIn: String
        Text(textIn).font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
    }
}

struct GameSettingsDisplay: View {
    let multiChoice: Bool
    let difficulty: String
    let regionMode: String
    let region: String
    let sateliteMapOn: Bool

    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 16) {
                // Game Mode
                HStack(spacing: 4) {
                    let gameModeIcon = multiChoice ? "checklist" : "keyboard"
                    let gameModeText = multiChoice ? Const.modeMultiChoiceText : Const.modeFillBlankText
                    Image(systemName: gameModeIcon)
                        .font(.system(size: Const.fontSizeNormStd - 3))
                    Text(gameModeText)
                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                }
                .foregroundColor(.gray)

                // Difficulty
                HStack(spacing: 4) {
                    let difficultyIcon = difficulty == Const.modeDiffEasyText ? "star" : (difficulty == Const.modeDiffMedText ? "star.leadinghalf.filled" : "star.fill")
                    Image(systemName: difficultyIcon)
                        .font(.system(size: Const.fontSizeNormStd - 3))
                    Text(difficulty)
                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                }
                .foregroundColor(.gray)
            }

            HStack(spacing: 16) {
                // Region Mode & Region
                HStack(spacing: 4) {
                    let regionIcon = regionMode == Const.modeRegCountryText ? "globe" : (regionMode == Const.modeRegRegionText ? "building.2" : "building.2.fill")
                    Image(systemName: regionIcon)
                        .font(.system(size: Const.fontSizeNormStd - 3))
                    if regionMode == Const.modeRegCountryText {
                        Text(regionMode)
                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                    } else {
                        let regionText = region == Const.modeRegCountryText ? "World" : region
                        Text("\(regionMode) • \(regionText)")
                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                    }
                }
                .foregroundColor(.gray)

                // Map Type
                HStack(spacing: 4) {
                    let mapViewIcon = sateliteMapOn ? "globe.americas.fill" : "map"
                    Image(systemName: mapViewIcon)
                        .font(.system(size: Const.fontSizeNormStd - 3))
                    Text(sateliteMapOn ? "Satellite" : "Standard")
                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                }
                .foregroundColor(.gray)
            }
        }
    }
}

struct ViewAssets_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
