//
//  LogIn.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/7/23.
//

import SwiftUI

//@State var userName: String = ""

struct LogIn: View {
    @State var userName: String = ""
    @State var password: String = ""
    let eye = UIImage(named: "eye")
    var body: some View {
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
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}
