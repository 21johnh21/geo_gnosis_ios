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
            TextField("Choose a Region", text: $countrySelection).background(CustomColor.trim)
            
            ZStack {
                RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2).padding(.trailing)
                ScrollView{
                    
                    ForEach(countries.indices){ index in
                        if(countries[index].hasPrefix(countrySelection)){
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(gameInfo.region == countries[index] ? CustomColor.trim : CustomColor.primary).padding(.trailing)//make it visible only when a county is selected
                                
                                Text(("\(countries[index])"))
                                    .onTapGesture {
                                        gameInfo.region=countries[index]
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
//extension UIScreen{
//   static let screenWidth = UIScreen.main.bounds.size.width
//   static let screenHeight = UIScreen.main.bounds.size.height
//   static let screenSize = UIScreen.main.bounds.size
//}

struct DropDown_Previews: PreviewProvider {
    static var previews: some View {
        DropDown()
    }
}
