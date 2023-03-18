//
//  ViewAssets.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/18/23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [CustomColor.backgrad1, CustomColor.secondary]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
    }
}

struct ViewAssets_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
