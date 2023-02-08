//
//  Settings.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/7/23.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject private var coordinator: Coordinator
    @State var vibOn: Bool = true
    @State var sound: Double = 100
    @State var sateliteMapOn: Bool = false
    
    var body: some View {
        VStack{
            Text("Geo Gnosis").font(.title)
            HStack{
                Text("Log In")//either say login or thier user name here
                Spacer()
                Image("defaultProfile").resizable()
                    .frame(width: 20.0, height: 20.0).padding().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay {
                        Circle().stroke(.black, lineWidth: 4)
                    }
                    .shadow(radius: 7).padding()
                    .onTapGesture {
                        coordinator.show(LogIn.self)
                    }
                    //.frame(width: 20.0, height: 20.0).padding()
                    
            }
            Toggle("Vibration On", isOn: $vibOn)
            Slider(value: $sound, in: 0...100).tint(Color.green).padding()
            //var soundText = String(format: "%.0f", sound)
            Text("Volume \(String(format: "%.0f", sound))")
                //Slider()
            Toggle("Satelite Map Mode", isOn: $sateliteMapOn)
            Spacer()
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
