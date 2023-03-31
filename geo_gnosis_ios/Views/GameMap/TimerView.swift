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
        ZStack{
            RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                .frame(width: 80, height: 30)
            Text("\(timerGlobal.timerGlobal)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)).onReceive(timer){ _ in
                timerGlobal.timerGlobal -= 1
                count = timerGlobal.timerGlobal
                if(timerGlobal.timerGlobal <= 0){
                    timer.upstream.connect().cancel()
                    timerGlobal.timerGlobal = 0
                }
            }
        }.padding(.trailing)
            .onDisappear(){
                if(roundInfo.times[roundInfo.roundNumber] != -1){ //TODO: This may break no on give up 
                }
                timer.upstream.connect().cancel()
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
