//
//  TimerView.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/21/23.
//

import SwiftUI

struct TimerView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                .frame(width: 80, height: 30)
            Text("\(count)").font(.custom("Changa-Light", size: 16)).onReceive(timer){ _ in
                count += 1
            }
        }.padding(.trailing)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
