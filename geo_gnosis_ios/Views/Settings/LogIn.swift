//
//  LogIn.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/7/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseAuth

struct LogIn: View {
    @AppStorage("userName") var userNameSt: String = ""
    @AppStorage("userID") var userIDSt: String = ""
    
    @EnvironmentObject var userData: UserInfo
    
    @State var userName: String = ""
    @State var deleteAccount: Bool = false
    //@State var password: String = ""
    @State var passwordLI: String = ""
    @State var passwordCA: String = ""
    @State var passwordConCA: String = ""
    @State var emailLI: String = ""
    @State var emailCA: String = ""
    //@State var email: String = ""
    
    @State var user: User?
    
    let eye = UIImage(named: "eye")
    var body: some View {
        if(userIDSt == "") { //If the user is not signed in
        //if(true) { //If the user is not signed in
            //TODO: Check if userName is already used? 
            VStack{
                //MARK: Login -------------------------------------------------------
                VStack{
                    Text("Have an account?")
                    TextField("email", text: $emailLI).textInputAutocapitalization(.never).autocorrectionDisabled(true)
                    SecureInputView("Password", text: $passwordLI)
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
                        TextField("user@sample.com", text: $emailCA).textInputAutocapitalization(.never).autocorrectionDisabled(true)
                    }
                    SecureInputView("Password", text: $passwordCA)
                    Text("At least 8 charachters\nOne Upper and one lower case\nOne number\nOne Special Charachter")
                    SecureInputView("Password", text: $passwordConCA)
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
                Text("Logged in as \(userNameSt)")
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 150, height: 30)
                    Text("Log Out")
                }.onTapGesture {
                    SignOut()
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 150, height: 30)
                    Text("Delete Account")
                }.onTapGesture {
                    deleteAccount = true
                }.confirmationDialog("Are you sure", isPresented: $deleteAccount){
                    Text("Are you sure?")
                    Button("Yes"){
                        DeleteAccount()
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
            let authResult = try await Auth.auth().signIn(withEmail: emailLI, password: passwordLI)
            print("login: \(authResult)")
            user = authResult.user
            print("user: \(String(describing: user))")
            var uuid = user?.uid
            print("user ID: \(String(describing: uuid))")
            //authenticationState = .authenticated
            var displayName = user?.displayName
            print("display name: \(String(describing: displayName))")
            //SetUserData(userID: user!.uid, displayName: user!.displayName!) //TODO: validate that this info is here
            userIDSt = user?.uid ?? "" //user is not availible use "" as default text
            userNameSt = user?.displayName ?? ""
        }
        catch{
            print("Error: \(error.localizedDescription)")
        }
    }
    func callSignIn () {
        Task{
            await SignInWithEmailAndPass()
        }
    }

    func CreateAccWithEmailAndPass(){
        Auth.auth().createUser(withEmail: emailCA, password: passwordCA) { user, error in
            if error == nil && user != nil {
                print("User created!")
                    
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = userName
                      
                changeRequest?.commitChanges { error in
                if error == nil {
                print("User display name changed!")
                              //self.dismiss(animated: false, completion: nil)
                } else {
                    print("Error: \(error!.localizedDescription)")
                }
            }
                      
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
        let currentUser = Auth.auth().currentUser
        userIDSt = currentUser?.uid ?? "" //user is not availible use "" as default text
        userNameSt = currentUser?.displayName ?? ""
        //print("userid: \(currentUser?.uid) displayName: \(currentUser?.displayName)")
    }
    
    func DeleteAccount(){
        Auth.auth().currentUser?.delete()
        userIDSt = ""
        userName = ""
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
