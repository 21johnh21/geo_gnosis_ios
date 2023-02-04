//
//  DropDown.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/4/23.
//

import SwiftUI

struct DropDown: View {
    
    @State var countrySelection: String = "USA"
    let countries = ["USA", "UK", "Mexico", "Canada"]
    
    var body: some View {
        
        VStack(alignment: .leading){
            TextField("Choose a Region", text: $countrySelection)
            ScrollView{
                
                ForEach(countries.indices){ index in
                    if(countries[index].hasPrefix(countrySelection)){
                        Text(("\(countries[index])"))
                    }
                }
            }.overlay{
                RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
            }
        }.frame(height: 80)
    }
}

struct DropDown_Previews: PreviewProvider {
    static var previews: some View {
        DropDown()
    }
}
