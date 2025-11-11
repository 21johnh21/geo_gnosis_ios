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

    @AppStorage("sateliteMapOn") var sateliteMapOn: Bool = false

    var body: some View {
        VStack(spacing: 16){
            // Game Mode Section
            VStack(alignment: .leading, spacing: 8) {
                Text("Game Mode")
                    .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    .fontWeight(.semibold)
                Picker("Choose a Mode:", selection: $multiChoice){
                    ForEach(multiChoiceModes, id: \.self){
                        Text($0).font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    }
                }
                .pickerStyle(.segmented)
                .colorMultiply(CustomColor.primary)
                .background(CustomColor.trim)
                .cornerRadius(5)
            }

            Divider()
                .background(CustomColor.trim2)

            // Difficulty Section
            VStack(alignment: .leading, spacing: 8) {
                Text("Difficulty")
                    .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    .fontWeight(.semibold)
                Picker("Choose a difficulty", selection: $difficulty){
                    ForEach(difficulties, id: \.self){
                        Text($0).font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    }
                }
                .pickerStyle(.segmented)
                .colorMultiply(CustomColor.primary)
                .background(CustomColor.trim)
                .cornerRadius(5)
            }

            Divider()
                .background(CustomColor.trim2)

            // Region Mode Section
            VStack(alignment: .leading, spacing: 8) {
                Text("Guess the")
                    .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    .fontWeight(.semibold)
                Picker("Choose a Region Mode", selection: $regionMode){
                    ForEach(regionModes, id: \.self){
                        Text($0).font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    }
                }
                .pickerStyle(.segmented)
                .colorMultiply(CustomColor.primary)
                .background(CustomColor.trim)
                .cornerRadius(5)

                if(regionMode != Const.modeRegCountryText){
                    DropDown(region: $region)
                        .padding(.top, 4)
                }
            }

            Divider()
                .background(CustomColor.trim2)

            // Map Settings Section
            VStack(alignment: .leading, spacing: 8) {
                Text("Map Settings")
                    .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    .fontWeight(.semibold)
                HStack {
                    Text("Satellite View")
                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                    Spacer()
                    Toggle("", isOn: $sateliteMapOn)
                        .labelsHidden()
                }
            }
        }
        .padding(20)
        .background(){
            RoundedRectangle(cornerRadius: 5) .fill(CustomColor.primary)
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetUpGame()
//    }
//}
