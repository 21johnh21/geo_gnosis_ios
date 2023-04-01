//
//  Penalty.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/29/23.
//

import SwiftUI

struct Penalty: View {
    
    @State private var isAnimating = false
    var penaltyAmount: Int
    
    var body: some View {
        let widthBound = UIScreen.main.bounds.width / 2
        let heightBound: Double = -(UIScreen.main.bounds.height / 2)
        
        Text("-\(penaltyAmount)")
            .font(.system(size: 60))
            .fontWeight(.bold)
            .foregroundColor(.red)
            .rotationEffect(Angle(degrees: isAnimating ? 30 : -30), anchor: .center)
            .offset(y: isAnimating ? heightBound : 0)
            .offset(x: isAnimating ? widthBound: 0)
            .opacity(isAnimating ? 0 : 1)
            .animation(.easeInOut(duration: 1).repeatCount(0, autoreverses: true), value: isAnimating)
            .onAppear {
                self.isAnimating = true
            }
    }
}

struct Penalty_Previews: PreviewProvider {
    static var previews: some View {
        Penalty(penaltyAmount: 20)
    }
}
