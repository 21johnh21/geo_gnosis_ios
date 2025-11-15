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
        VStack(alignment: .leading, spacing: 8){
            // Search Field
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: Const.fontSizeNormStd - 2))
                    .foregroundColor(.gray)
                TextField("Search region...", text: $countrySelection)
                    .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 1))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)
                if !countrySelection.isEmpty {
                    Button(action: {
                        countrySelection = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: Const.fontSizeNormStd - 2))
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(CustomColor.primary)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
            )

            // Dropdown List
            ScrollView{
                VStack(spacing: 4) {
                    ForEach(countries.indices){ index in
                        if(countries[index].lowercased().hasPrefix(countrySelection.lowercased()) || countrySelection.isEmpty){
                            Button(action: {
                                PlayDefaultFeedback().play()
                                region = countries[index]
                                countrySelection = ""
                            }) {
                                HStack {
                                    Text(countries[index])
                                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 1))
                                        .foregroundColor(.primary)
                                    Spacer()
                                    if region == countries[index] {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: Const.fontSizeNormStd - 2))
                                            .foregroundColor(.green)
                                    }
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                                        .fill(region == countries[index] ? CustomColor.secondary.opacity(0.3) : CustomColor.primary)
                                )
                            }
                        }
                    }
                }
                .padding(4)
            }
            .frame(maxHeight: 140)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(CustomColor.trim2)
                    .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
            )
        }
    }
}

//struct DropDown_Previews: PreviewProvider {
//    static var previews: some View {
//        DropDown()
//    }
//}
