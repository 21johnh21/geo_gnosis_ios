//
//  EndGameCard.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/28/23.
//

import SwiftUI

struct EndGameCard: View {

    var location: Location
    var roundNumber: Int
    var time: Int
    var answer: Bool

    var body: some View {
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(CustomColor.primary)
                .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)

            // Answer indicator badge
            ZStack{
                Circle()
                    .fill(answer ? Color.green : Color.red)
                    .frame(width: 28, height: 28)
                Text(answer ? "✓" : "✗")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
            .offset(x: -8, y: -8)
            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)

            HStack(spacing: 16) {
                // Left Side - Round and Score
                VStack(alignment: .leading, spacing: 8){
                    Text("Round \(roundNumber)")
                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                        .fontWeight(.bold)
                    if(time != -1){
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Score:")
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                .foregroundColor(.gray)
                            Text("\(time)")
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd + 2))
                                .fontWeight(.semibold)
                        }
                    }else{
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Score:")
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                                .foregroundColor(.gray)
                            Text("DNF")
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd + 2))
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Divider()
                    .background(CustomColor.trim2)

                // Right Side - Location Details
                VStack(alignment: .leading, spacing: 6){
                    HStack {
                        Text("City:")
                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                            .foregroundColor(.gray)
                            .frame(width: 60, alignment: .leading)
                        Text(location.city_ascii)
                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 1))
                    }
                    HStack {
                        Text("District:")
                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                            .foregroundColor(.gray)
                            .frame(width: 60, alignment: .leading)
                        Text(location.admin_name)
                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 1))
                    }
                    HStack {
                        Text("Country:")
                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 2))
                            .foregroundColor(.gray)
                            .frame(width: 60, alignment: .leading)
                        Text(location.country)
                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd - 1))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
        }
        .frame(height: 150)
    }
}


