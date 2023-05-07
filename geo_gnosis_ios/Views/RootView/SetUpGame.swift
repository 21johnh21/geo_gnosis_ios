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
    
    var body: some View {
        VStack(spacing: 0){
            Text("Game Mode:").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
            Picker("Choose a Mode:", selection: $multiChoice){
                ForEach(multiChoiceModes, id: \.self){
                    Text($0).font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                }
            }.pickerStyle(.segmented).colorMultiply(CustomColor.primary).background(CustomColor.trim).cornerRadius(5)
            Text("Difficulty:").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
            Picker("Choose a difficulty", selection: $difficulty){
                ForEach(difficulties, id: \.self){
                    Text($0).font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                }
            }.pickerStyle(.segmented).colorMultiply(CustomColor.primary).background(CustomColor.trim).cornerRadius(5)
            Text("Guess the:").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
            Picker("Choose a Region Mode", selection: $regionMode){
                ForEach(regionModes, id: \.self){
                    Text($0).font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                }
            }.pickerStyle(.segmented).colorMultiply(CustomColor.primary).background(CustomColor.trim).cornerRadius(5)
            if(regionMode != Const.modeRegCountryText){
                DropDown(region: $region).padding(.top)
            }
        }.padding()
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
