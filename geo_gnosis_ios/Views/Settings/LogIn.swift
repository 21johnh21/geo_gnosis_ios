//
//  LogIn.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/7/23.
//

import SwiftUI
import FirebaseAuth

struct LogIn: View {
    @AppStorage("userName") var userNameSt: String = ""
    @AppStorage("userID") var userIDSt: String = ""
    
    @State var password: String = ""
    @State var email: String = ""
    @State var hadErrorLoggingIn: Bool = false
    let loginErrorMessage = "Incorrect Email or Password"
    
    @State var user: User?
    
    var body: some View {
        if(userIDSt == "") { //If the user is not signed in
            ScrollView{
                //MARK: Login -------------------------------------------------------
                VStack{
                    Text("Have an account?")
                    if(false){
                        SignInWithApple()
                    }
                    Text("Or sign in with email")
                    VStack{
                        TextField("email", text: $email).textInputAutocapitalization(.never).autocorrectionDisabled(true)
                        SecureInputView("Password", text: $password)
                    }.padding().overlay(){
                        RoundedRectangle(cornerRadius: 5).stroke(.black, lineWidth: 5)
                    }
                    if(hadErrorLoggingIn){
                        Text("\(loginErrorMessage)")
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 5).fill(.green).frame(width: 150, height: 30)
                        Text("Login")
                    }.onTapGesture {
                        callSignIn()
                    }
                }.padding().background(){
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                }
                .overlay(){
                    RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
                }
                //MARK: Create an Account -------------------------------------------------------
                CreateAccount()
                Spacer()
            }
            .background(alignment: .center){BackgroundView()}
        }
        else {
            //MARK: Already Logged In  -------------------------------------------------------
            LoggedIn()
        }
    }
    func SignInWithEmailAndPass() async{
        do{
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            print("login: \(authResult)")
            user = authResult.user
            print("user: \(String(describing: user))")
            let uuid = user?.uid
            print("user ID: \(String(describing: uuid))")
            let displayName = user?.displayName
            print("display name: \(String(describing: displayName))")
            userIDSt = user?.uid ?? ""
            userNameSt = user?.displayName ?? ""
        }
        catch{
            hadErrorLoggingIn = true
            print("Error: \(error.localizedDescription)")
        }
    }
    func callSignIn () {
        Task{
            await SignInWithEmailAndPass()
        }
    }
}

//struct LogIn_Previews: PreviewProvider {
//    static var previews: some View {
//        LogIn()
//    }
//}
