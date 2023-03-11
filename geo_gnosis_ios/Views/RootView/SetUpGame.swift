//
//  SetUpGame.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/11/23.
//

import SwiftUI

struct SetUpGame: View {
    
    //@State var multiChoice = "Multiple Choice"
    @Binding var multiChoice: String
    var multiChoiceModes = ["Multiple Choice", "Fill the Blank"]
    //@State var difficulty = "Easy"
    @Binding var difficulty: String
    var difficulties = ["Easy", "Medium", "Hard"]
    //@State var regionMode = "World"
    @Binding var regionMode: String
    var regionModes = ["World", "State", "City"]
    
    var body: some View {
        VStack(spacing: 0){
            Text("Set Up Game").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
            Text("Game Mode").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
            Picker("Choose a Mode", selection: $multiChoice){
                ForEach(multiChoiceModes, id: \.self){
                    Text($0).font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                }
            }.pickerStyle(.segmented).colorMultiply(CustomColor.primary).background(CustomColor.trim).cornerRadius(5)
            Text("Difficulty").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
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
            if(regionMode != "World"){
                DropDown()
            }
        }.padding().overlay(){
            RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetUpGame()
//    }
//}
