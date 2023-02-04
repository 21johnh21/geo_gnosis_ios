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
    let countries = ["United States", "United Kingdom", "Mexico", "Canada"]
    
    var body: some View {
        
        VStack(alignment: .leading){
            TextField("Choose a Region", text: $countrySelection)
            ScrollView{
                
                ForEach(countries.indices){ index in
                    if(countries[index].hasPrefix(countrySelection)){
                        Text(("\(countries[index])"))
                            .onTapGesture {
                                gameInfo.region=countries[index]
                            }
                    }
                }
            }.overlay{
                RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
            }
        }.frame(height: 80).padding(.leading)
    }
}

struct DropDown_Previews: PreviewProvider {
    static var previews: some View {
        DropDown()
    }
}
