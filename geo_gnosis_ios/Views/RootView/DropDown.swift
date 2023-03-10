//
//  DropDown.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/4/23.
//

import SwiftUI

struct DropDown: View {
    @EnvironmentObject var gameInfo: GameInfo
    @State var countrySelection: String = ""
    let screenWidth = UIScreen.main.bounds.size.width
    let countries = ["United States", "United Kingdom", "Mexico", "Canada"]
    
    var body: some View {
        
        VStack(alignment: .leading){
            TextField("Choose a Region", text: $countrySelection).font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)).background(CustomColor.trim)
            
            ZStack {
                RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2).padding(.trailing)
                ScrollView{
                    
                    ForEach(countries.indices){ index in
                        if(countries[index].hasPrefix(countrySelection)){
                            ZStack{
                                Text(("\(countries[index])")).font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    .onTapGesture {
                                        gameInfo.region=countries[index]
                                    }
                                .frame(maxWidth: .infinity)
                                .background(){
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(gameInfo.region == countries[index] ? CustomColor.primary : CustomColor.trim).padding(.trailing)
                                }
                            }
                            .onTapGesture {
                                gameInfo.region=countries[index]
                            }
                        }
                    }
                }
            }//.overlay{
//                RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
//                    //.frame(width: screenWidth)
//            }
        }.frame(maxHeight: 100).padding(.leading)
    }
}

struct DropDown_Previews: PreviewProvider {
    static var previews: some View {
        DropDown()
    }
}
