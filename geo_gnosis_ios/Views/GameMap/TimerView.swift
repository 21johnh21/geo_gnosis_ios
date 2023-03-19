//
//  TimerView.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/21/23.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject var roundInfo : RoundInfo
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                .frame(width: 80, height: 30)
            Text("\(count)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)).onReceive(timer){ _ in
                count += 1
            }
        }.padding(.trailing)
            .onDisappear(){
                if(roundInfo.times[roundInfo.roundNumber] != -1){
                    if(roundInfo.roundNumber == 4 && roundInfo.roundNumbers[4] != 0){
                        //this is super hacky but it allows me to set the time on the last round
                        //If I increment the roundnumer on the last round it tries to update the map and causes an index out of bounds error.
                        roundInfo.times[roundInfo.roundNumber] = count
                    }else{
                        roundInfo.times[roundInfo.roundNumber - 1] = count
                    }
                }
                print(roundInfo.roundNumber)
                print(roundInfo.times[roundInfo.roundNumber - 1])
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
