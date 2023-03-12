//
//  PrivacyPolicy.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/11/23.
//

import SwiftUI

struct PrivacyPolicy: View {
    @Binding var showPriacyPolicy: Bool
    @State private var drag: CGFloat = 0
    
    var body: some View {
        if(showPriacyPolicy){
            VStack{
                Image(systemName: "chevron.down").padding()
                Text("Privacy Policy")
                Text("Geo Gnosis does not collect any personal information from any of your use of our Apps. If we have any of your personal information we will not willingly sell or give it to anyone, except if lawfully subpoenaed to produce it and then only after offering you a reasonable chance to challenge such subpoena if allowed by law.").padding()
            }
            .transition(.move(edge: .bottom))
            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: 1)
            .background(){
                RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).shadow(radius: 10)
            }
            .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                .onChanged { value in
                        self.drag = value.translation.height
                }.onEnded { _ in
                    withAnimation{
                        showPriacyPolicy.toggle()
                        self.drag = 0
                    }
                })
        }
    }
}

//struct PrivacyPolicy_Previews: PreviewProvider {
//    static var previews: some View {
//        PrivacyPolicy()
//    }
//}
