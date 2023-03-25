//
//  Progress.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/23/23.
//

import SwiftUI

struct Progress: View {
    
    @State var isRotating = 0.0
    
    var body: some View {
        let gradient = Gradient(colors: [.green, .blue])
        let linearGradient = LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing)
        let style = StrokeStyle(lineWidth: 15, lineCap: .butt, lineJoin: .round, miterLimit: 1, dash: [], dashPhase: 0)
        ZStack{
            Image(Const.picLogo).resizable().frame(width: 255, height: 255).clipShape(Circle()).padding()
            
            Circle()
                .strokeBorder(linearGradient, style: style)
                .rotationEffect(.degrees(isRotating))
                .frame(width: 180, height: 180)
                .onAppear {
                    withAnimation(.linear(duration: 1) .speed(0.5).repeatForever(autoreverses: false)) {
                        isRotating = 360.0
                    }
                }
        }
    }
}

struct Progress_Previews: PreviewProvider {
    static var previews: some View {
        Progress()
    }
}
