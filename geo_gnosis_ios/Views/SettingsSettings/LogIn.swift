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
    
    @EnvironmentObject var userData: UserInfo
    
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
                //MARK: Login -------------------------------------------------------
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
                    //MARK: Create an Account -------------------------------------------------------
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
                        //CallCreateAcc()
                        CreateAccWithEmailAndPass()
                    }
                }.padding().overlay(){
                    RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
                }
                Spacer()
            }
        }
        else {
            //MARK: Already Logged In  -------------------------------------------------------
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
            print("user: \(String(describing: user))")
            var uuid = user?.uid
            print("user ID: \(String(describing: uuid))")
            //authenticationState = .authenticated
            var displayName = user?.displayName
            print("display name: \(displayName)")
            //SetUserData(userID: user!.uid, displayName: user!.displayName!) //TODO: validate that this info is here
        }
        catch{
            
        }
    }
    func callSignIn () {
        email = userName //TODO: remove this
        Task{
            await SignInWithEmailAndPass()
        }
    }
    func CreateAccWithEmailAndPass(){
        Auth.auth().createUser(withEmail: userName, password: password, completion: { user, error in
            if let error = error {
                print("ERROR : Auth.auth().createUser -> ", error.localizedDescription)
                          
            } else {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = userName
                changeRequest?.commitChanges(completion: nil)
            }
        })
    }
    func DeleteAccount(){
        //TODO: delete account
    }
    func SetUserData(userID: String, displayName: String){
        userData.userID = userID
        userData.displayName = displayName
        print("userID: \(userData.userID), displayName: \(userData.displayName)")
    }
}

//struct LogIn_Previews: PreviewProvider {
//    static var previews: some View {
//        LogIn()
//    }
//}
