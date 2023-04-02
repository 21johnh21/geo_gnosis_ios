//
//  LoggedIn.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/10/23.
//

import SwiftUI
import FirebaseAuth

struct LoggedIn: View {
    @AppStorage("userName") var userNameSt: String = ""
    @AppStorage("userID") var userIDSt: String = ""
    
    @State var deleteAccount: Bool = false
    
    
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 80)
                Text("Profile").font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg)).padding(.top).padding(.top)
            }
            ZStack{
                RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                Text("Logged in as \(userNameSt)")
            }
            Image(Const.picLogo).resizable().frame(width: 255, height: 255).clipShape(Circle()).padding()
            HStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 150, height: 30)
                    Text("Log Out")
                }.onTapGesture {
                    SignOut()
                }.padding(.leading)
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 150, height: 30)
                    Text("Delete Account")
                }.padding(.trailing)
                .onTapGesture {
                    deleteAccount = true
                }.confirmationDialog("Are you sure", isPresented: $deleteAccount){
                    Text("Are you sure?")
                    Button("Yes"){
                        DeleteAccount()
                    }
                } message: {
                    Text("Are you sure?")
                }
            }
            Spacer()
        }.background(alignment: .center){BackgroundView()}
        //.frame(maxWidth: .infinity).background(CustomColor.secondary)

    }
    func DeleteAccount(){
        Auth.auth().currentUser?.delete()
        userIDSt = ""
        userNameSt = ""
    }
    func SignOut(){
        do{
            try Auth.auth().signOut()
            userIDSt = ""
            userNameSt = ""
        }catch{
            print(error.localizedDescription)
        }
    }
}

struct LoggedIn_Previews: PreviewProvider {
    static var previews: some View {
        LoggedIn()
    }
}
