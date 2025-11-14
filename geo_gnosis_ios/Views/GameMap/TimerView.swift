//
//  TimerView.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/21/23.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject var roundInfo : RoundInfo
    @EnvironmentObject var timerGlobal : TimerGlobal
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "clock.fill")
                .font(.system(size: Const.fontSizeNormStd - 2))
                .foregroundColor(.primary)
            Text("\(timerGlobal.timerGlobal > 0 ? timerGlobal.timerGlobal : 0)")
                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                .fontWeight(.semibold)
                .onReceive(timer){ _ in
                    timerGlobal.timerGlobal -= 1
                    count = timerGlobal.timerGlobal
                    if(timerGlobal.timerGlobal <= 0){
                        timer.upstream.connect().cancel()
                        timerGlobal.timerGlobal = 0
                    }
                }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(CustomColor.primary)
                .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
        )
        .padding(.trailing, 12)
        .onDisappear(){
            timer.upstream.connect().cancel()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
