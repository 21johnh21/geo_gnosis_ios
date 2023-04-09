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

struct PlayDefaultFeedback {
    @AppStorage("vibOn") var vibOn: Bool = true
    
    let generator = UIImpactFeedbackGenerator(style: .light)
    func play(){
        if(vibOn){
            generator.impactOccurred()
        }
    }
}

struct StdText: View {
    @State var textIn: String
    var body: some View {
        //@State var textIn: String
        Text(textIn).font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
    }
}

struct ViewAssets_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
