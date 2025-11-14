//
//  SetUpGame.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/11/23.
//

import SwiftUI

struct SetUpGame: View {

    @Binding var multiChoice: String
    var multiChoiceModes = [Const.modeMultiChoiceText, Const.modeFillBlankText]
    @Binding var difficulty: String
    var difficulties = [Const.modeDiffEasyText, Const.modeDiffMedText, Const.modeDiffHardText]
    @Binding var regionMode: String
    var regionModes = [Const.modeRegCountryText, Const.modeRegRegionText, Const.modeRegCityText]
    @Binding var region: String

    @AppStorage("sateliteMapOn") var sateliteMapOn: Bool = true

    var body: some View {
        VStack(spacing: 12){
            // Game Mode Section
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 6) {
                    Image(systemName: multiChoice == Const.modeMultiChoiceText ? "checklist" : "keyboard")
                        .font(.system(size: Const.fontSizeNormStd - 2))
                        .foregroundColor(.gray)
                    Text("Game Mode")
                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                        .fontWeight(.semibold)
                }
                HStack(spacing: 8) {
                    ForEach(multiChoiceModes, id: \.self) { mode in
                        Button(action: {
                            PlayDefaultFeedback().play()
                            multiChoice = mode
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: mode == Const.modeMultiChoiceText ? "checklist" : "keyboard")
                                    .font(.system(size: Const.fontSizeNormStd - 4))
                                Text(mode)
                                    .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(multiChoice == mode ? CustomColor.secondary : CustomColor.trim)
                            )
                            .foregroundColor(multiChoice == mode ? .primary : .secondary)
                        }
                    }
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(CustomColor.primary)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
            )

            // Difficulty Section
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 6) {
                    let difficultyIcon = difficulty == Const.modeDiffEasyText ? "star" : (difficulty == Const.modeDiffMedText ? "star.leadinghalf.filled" : "star.fill")
                    Image(systemName: difficultyIcon)
                        .font(.system(size: Const.fontSizeNormStd - 2))
                        .foregroundColor(.gray)
                    Text("Difficulty")
                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                        .fontWeight(.semibold)
                }
                HStack(spacing: 8) {
                    ForEach(difficulties, id: \.self) { diff in
                        Button(action: {
                            PlayDefaultFeedback().play()
                            difficulty = diff
                        }) {
                            HStack(spacing: 4) {
                                let icon = diff == Const.modeDiffEasyText ? "star" : (diff == Const.modeDiffMedText ? "star.leadinghalf.filled" : "star.fill")
                                Image(systemName: icon)
                                    .font(.system(size: Const.fontSizeNormStd - 4))
                                Text(diff)
                                    .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 3))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(difficulty == diff ? CustomColor.secondary : CustomColor.trim)
                            )
                            .foregroundColor(difficulty == diff ? .primary : .secondary)
                        }
                    }
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(CustomColor.primary)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
            )

            // Region Mode Section
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 6) {
                    let regionIcon = regionMode == Const.modeRegCountryText ? "globe" : (regionMode == Const.modeRegRegionText ? "building.2" : "building.2.fill")
                    Image(systemName: regionIcon)
                        .font(.system(size: Const.fontSizeNormStd - 2))
                        .foregroundColor(.gray)
                    Text("Guess the")
                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                        .fontWeight(.semibold)
                }
                HStack(spacing: 8) {
                    ForEach(regionModes, id: \.self) { mode in
                        Button(action: {
                            PlayDefaultFeedback().play()
                            regionMode = mode
                        }) {
                            HStack(spacing: 4) {
                                let icon = mode == Const.modeRegCountryText ? "globe" : (mode == Const.modeRegRegionText ? "building.2" : "building.2.fill")
                                Image(systemName: icon)
                                    .font(.system(size: Const.fontSizeNormStd - 4))
                                Text(mode)
                                    .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 3))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(regionMode == mode ? CustomColor.secondary : CustomColor.trim)
                            )
                            .foregroundColor(regionMode == mode ? .primary : .secondary)
                        }
                    }
                }

                if(regionMode != Const.modeRegCountryText){
                    DropDown(region: $region)
                        .padding(.top, 4)
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(CustomColor.primary)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
            )

            // Map Settings Section
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 6) {
                    let mapIcon = sateliteMapOn ? "globe.americas.fill" : "map"
                    Image(systemName: mapIcon)
                        .font(.system(size: Const.fontSizeNormStd - 2))
                        .foregroundColor(.gray)
                    Text("Map View")
                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                        .fontWeight(.semibold)
                }
                HStack(spacing: 8) {
                    Button(action: {
                        PlayDefaultFeedback().play()
                        sateliteMapOn = true
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "globe.americas.fill")
                                .font(.system(size: Const.fontSizeNormStd - 4))
                            Text("Satellite")
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(sateliteMapOn ? CustomColor.secondary : CustomColor.trim)
                        )
                        .foregroundColor(sateliteMapOn ? .primary : .secondary)
                    }

                    Button(action: {
                        PlayDefaultFeedback().play()
                        sateliteMapOn = false
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "map")
                                .font(.system(size: Const.fontSizeNormStd - 4))
                            Text("Standard")
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(!sateliteMapOn ? CustomColor.secondary : CustomColor.trim)
                        )
                        .foregroundColor(!sateliteMapOn ? .primary : .secondary)
                    }
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
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(CustomColor.primary)
                .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 3)
        )
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetUpGame()
//    }
//}
