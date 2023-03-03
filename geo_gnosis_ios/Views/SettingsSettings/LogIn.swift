//
//  LogIn.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/7/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseAuth

//@State var userName: String = ""

struct LogIn: View {
    @AppStorage("loggedIn") var loggedIn: Bool = false
    //@AppStorage("userName") var userName: String = ""
    
    @State var userName: String = ""
    @State var password: String = ""
    @State var deleteAccount: Bool = false
    @State var email: String = ""
    
    @State var user: User?
    
    let eye = UIImage(named: "eye")
    var body: some View {
        //@EnvironmentObject var viewModel: AuthenticationViewModel
        if(loggedIn == false) {
            VStack{
                VStack{
                    Text("Have an account?")
                    TextField("User Name", text: $userName).textInputAutocapitalization(.never).autocorrectionDisabled(true)
                    TextField("Password", text: $password).textInputAutocapitalization(.never).autocorrectionDisabled(true)
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(.green).frame(width: 150, height: 30)
                        Text("Login")
                    }.onTapGesture {
                        callSignIn()
                    }
                }.padding().overlay(){
                    RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
                }
                VStack{
                    Text("Create and Account")
                    HStack{
                        Text("User Name: ")
                        TextField("User Name", text: $userName).textInputAutocapitalization(.never).autocorrectionDisabled(true)
                    }
                    HStack{
                        Text("Email: ")
                        TextField("user@sample.com", text: $userName).textInputAutocapitalization(.never).autocorrectionDisabled(true)
                    }
                    HStack{
                        Text("Passord: ")
                        TextField("*******", text: $password).textInputAutocapitalization(.never).autocorrectionDisabled(true)
                        //put eye uiimage here
                        //or eye.slash
                    }
                    Text("At least 8 charachters\nOne Upper and one lower case\nOne number\nOne Special Charachter")
                    HStack{
                        Text("Confirm Password")
                        TextField("*******", text: $password).textInputAutocapitalization(.never).autocorrectionDisabled(true)
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(.green).frame(width: 150, height: 30)
                        Text("Create Account")
                    }.onTapGesture {
                        CallCreateAcc()
                    }
                }.padding().overlay(){
                    RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
                }
                Spacer()
            }
        }
        else {
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
                } message: {
                    Text("Are you sure?")
                }
            }
        }
    }
    func SignInWithEmailAndPass() async{
        do{
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            print("login: \(authResult)")
            user = authResult.user
            print("user: \(user)")
            //authenticationState = .authenticated
        }
        catch{
            
        }
    }
    func callSignIn () {
        //TODO: remove this
        email = userName
        Task{
            await SignInWithEmailAndPass()
        }
    }
    func CreateAccWithEmailAndPass() async{
        do{
            //TODO: prevent spaces / other bad charachters
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            //print("login: \(authResult)")
            user = authResult.user
            //print("user: \(user)")
            //authenticationState = .authenticated
        }
        catch{
            
        }
    }
    func CallCreateAcc(){
        Task{
            email = userName //TODO: remove this
            await CreateAccWithEmailAndPass()
        }
    }
    func DeleteAccount(){
        //TODO: delete account
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}
