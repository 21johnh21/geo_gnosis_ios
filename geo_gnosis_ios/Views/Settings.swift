//
//  Settings.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/7/23.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject private var coordinator: Coordinator
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
            Spacer()
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
