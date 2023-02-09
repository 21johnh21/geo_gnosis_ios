//
//  LogIn.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/7/23.
//

import SwiftUI

//@State var userName: String = ""

struct LogIn: View {
    @AppStorage("loggedIn") var loggedIn: Bool = false
    //@AppStorage("userName") var userName: String = ""
    
    @State var userName: String = ""
    @State var password: String = ""
    @State var deleteAccount: Bool = false
    
    let eye = UIImage(named: "eye")
    var body: some View {
        if(loggedIn == false) {
            VStack{
                VStack{
                    Text("Have an account?")
                    TextField("User Name", text: $userName)
                    TextField("Password", text: $password)
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(.green).frame(width: 150, height: 30)
                        Text("Login")
                    }
                }.padding().overlay(){
                    RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
                }
                VStack{
                    HStack{
                        Text("User Name: ")
                        TextField("User Name", text: $userName)
                    }
                    HStack{
                        Text("Email: ")
                        TextField("user@sample.com", text: $userName)
                    }
                    HStack{
                        Text("Passord: ")
                        TextField("*******", text: $password)
                        //put eye uiimage here
                        //or eye.slash
                    }
                    Text("At least 8 charachters\nOne Upper and one lower case\nOne number\nOne Special Charachter")
                    HStack{
                        Text("Confirm Password")
                        TextField("*******", text: $password)
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(.green).frame(width: 150, height: 30)
                        Text("Create Account")
                    }
                }.padding().overlay(){
                    RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
                }
                Spacer()
            }
        }
        VStack{
            Text("Logged in as \(userName)")
            ZStack{
                RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 150, height: 30)
                Text("Log Out")
            }.onTapGesture {
                loggedIn = false
                userName = ""
            }
            ZStack{
                RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 150, height: 30)
                Text("Delete Account")
            }.onTapGesture {
                deleteAccount = true
            }.confirmationDialog("Are you sure", isPresented: $deleteAccount){
                Text("Are you sure?")
                Button("Yes"){
                    loggedIn = false
                    userName = ""
                    //query data base and delete information
                    //when that returns true send confirmation
                }
                //Button("No"){}
            } message: {
                Text("Are you sure?")
            }
            
            //.onTapGesture {
//                //query data base and delete all user data
//                confirmationDialog("Are you sure?\nThis will delete your account and all related data", isPresented: $deleteAccount, actions: DeleteAccount())
//                    loggedIn = false
//                    userName = ""
//            }
            
//            confirmationDialog("Are you sure?\nThis will delete your account and all related data", isPresented: $deleteAccount, actions: DeleteAccount())
        }
    }
    func DeleteAccount(){
        
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}
