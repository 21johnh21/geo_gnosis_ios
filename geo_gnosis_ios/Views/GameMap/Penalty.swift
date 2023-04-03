//
//  Penalty.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/29/23.
//

import SwiftUI

struct Penalty: View {
    
    @EnvironmentObject var timerGlobal: TimerGlobal
    
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
            .onAppear {
                Task{
                    await animate(duration: 0.5){
                        isAnimating = true
                    }
                    timerGlobal.timerGlobal -= 5 //out of bounds penalty
                    timerGlobal.penalty = false
                }
            }
    }
}
extension View {
    func animate(duration: CGFloat, _ execute: @escaping () -> Void) async {
        await withCheckedContinuation { continuation in
            withAnimation(.linear(duration: duration)) {
                execute()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                continuation.resume()
            }
        }
    }
}

struct Penalty_Previews: PreviewProvider {
    static var previews: some View {
        Penalty(penaltyAmount: 20)
    }
}
