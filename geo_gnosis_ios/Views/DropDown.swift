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
    static let screenWidth = UIScreen.main.bounds.size.width
    let countries = ["United States", "United Kingdom", "Mexico", "Canada"]
    
    var body: some View {
        
        VStack(alignment: .leading){
            TextField("Choose a Region", text: $countrySelection)
            ScrollView{
                
                ForEach(countries.indices){ index in
                    if(countries[index].hasPrefix(countrySelection)){
                        ZStack{
                            if(gameInfo.region == countries[index]){
                                RoundedRectangle(cornerRadius: 5).fill(.green)
                            }
                            Text(("\(countries[index])"))
                                .onTapGesture {
                                    gameInfo.region=countries[index]
                                }
                        }
                    }
                }
            }.overlay{
                RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
                    .frame(width: DropDown.screenWidth)
            }
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
