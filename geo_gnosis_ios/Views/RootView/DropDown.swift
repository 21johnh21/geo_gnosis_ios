//
//  DropDown.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/4/23.
//

import SwiftUI

struct DropDown: View {
    
    @Binding var region: String
    
    @EnvironmentObject var gameInfo: GameInfo
    
    @State var countrySelection: String = ""
    let screenWidth = UIScreen.main.bounds.size.width
    let countries = ["World", "United States", "United Kingdom", "Mexico", "Canada"]
    
    var body: some View {
        //TODO: Make a Countries Data File to fill the Drop Down
        VStack(alignment: .leading){
            TextField("Choose a Region", text: $countrySelection)
                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                .background(CustomColor.trim2)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.words)

            ZStack {
                RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2).padding(.trailing)
                ScrollView{
                    
                    ForEach(countries.indices){ index in
                        if(countries[index].hasPrefix(countrySelection)){
                            ZStack{
                                Text(("\(countries[index])")).font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                .frame(maxWidth: .infinity)
                                .background(){
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(region == countries[index] ? CustomColor.primary : CustomColor.trim2).padding(.trailing)
                                }
                            }
                            .onTapGesture {
                                region = countries[index]
                            }
                        }
                    }
                }
            }
        }.frame(maxHeight: 100).padding(.leading)
    }
}

//struct DropDown_Previews: PreviewProvider {
//    static var previews: some View {
//        DropDown()
//    }
//}
