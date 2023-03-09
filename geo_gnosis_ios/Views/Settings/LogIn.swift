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
    @State var passwordLI: String = ""
    @State var passwordCA: String = ""
    @State var passwordConCA: String = ""
    @State var emailLI: String = ""
    @State var emailCA: String = ""
    @State var hadErrorLoggingIn: Bool = false
    let loginErrorMessage = "Incorrect Email or Password"
    @State var hadErrorCreatingAccount: Bool = false
    @State var createAccountErrorCode: Int = 0 //no error = 0
    
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
                    if(hadErrorLoggingIn){
                        Text("\(loginErrorMessage)")
                    }
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
                    Group{
                        Text("At least 8 charachters").foregroundColor(createAccountErrorCode == 1 ? .red : .black)
                        Text("One Upper and one lower case").foregroundColor(createAccountErrorCode == 2 ? .red : .black)
                        Text("One number").foregroundColor(createAccountErrorCode == 3 ? .red : .black)
                        Text("One Special Charachter").foregroundColor(createAccountErrorCode == 4 ? .red : .black)
                        if(createAccountErrorCode == 5){
                            Text("Passwords don't match").foregroundColor(.red)
                        }
                        if(createAccountErrorCode == 6){
                            Text("Must provide and email").foregroundColor(.red)
                        }
                        if(createAccountErrorCode == 7){
                            Text("Must provide a valid email").foregroundColor(.red)
                        }
                        if(createAccountErrorCode == 8){
                            Text("This email is already in use").foregroundColor(.red)
                        }
                        if(createAccountErrorCode == 9){
                            Text("Error creating an account").foregroundColor(.red)
                        }
                    }
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
            hadErrorLoggingIn = true
            print("Error: \(error.localizedDescription)")
        }
    }
    func callSignIn () {
        Task{
            await SignInWithEmailAndPass()
        }
    }

    func CreateAccWithEmailAndPass(){
        
        if(PassIsValid()){
            
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
                    //TODO: verify that the username is provided and not already in use
                    print("Error: \(error!.localizedDescription)")
                    if(error!.localizedDescription == "An email address must be provided."){ //no email
                        createAccountErrorCode = 6
                    }else if(error!.localizedDescription == "The email address is badly formatted."){ // email not valid
                        createAccountErrorCode = 7
                    }else if(error!.localizedDescription == "The email address is already in use by another account."){ // email not valid
                        createAccountErrorCode = 8
                    }else{ //generic error
                        createAccountErrorCode = 9
                    }
                }
            }
            let currentUser = Auth.auth().currentUser
            userIDSt = currentUser?.uid ?? "" //user is not availible use "" as default text
            userNameSt = currentUser?.displayName ?? ""
            //print("userid: \(currentUser?.uid) displayName: \(currentUser?.displayName)")
        }else{
            //TODO: Inform User
        }
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
    func PassIsValid() -> Bool{
        //crateAccountErrorMessage
        //hadErrorCreatingAccount
        
        var passIsValid: Bool = true
        
        let capREGEX = ".*[A-Z]+.*"
        let lowREGEX = ".*[a-z]+.*"
        let numREGEX = ".*[0-9]+.*"
        let spcREGEX = ".*[!&^%$#@()/]+.*"
        
        var testREGEX = NSPredicate(format:"SELF MATCHES %@", capREGEX)
        let hasCap = testREGEX.evaluate(with: passwordCA)
        
        testREGEX = NSPredicate(format:"SELF MATCHES %@", lowREGEX)
        let hasLow = testREGEX.evaluate(with: passwordCA)
        
        testREGEX = NSPredicate(format:"SELF MATCHES %@", numREGEX)
        let hasNum = testREGEX.evaluate(with: passwordCA)
        
        testREGEX = NSPredicate(format:"SELF MATCHES %@", spcREGEX)
        let hasSpc = testREGEX.evaluate(with: passwordCA)
        
        createAccountErrorCode = 0 
        
        if(!(passwordCA == passwordConCA)){ //pass + con pass dont match
            passIsValid = false
            createAccountErrorCode = 5
        }else if(passwordCA.count < 9){ // less than 8 chars
            passIsValid = false
            createAccountErrorCode = 1
        }else if(!hasCap){ //no cap
            passIsValid = false
            createAccountErrorCode = 2
        }else if(!hasLow){ //no lower
            passIsValid = false
            createAccountErrorCode = 2
        }else if(!hasNum){ //no number
            passIsValid = false
            createAccountErrorCode = 3
        }else if(!hasSpc){ //no special
            passIsValid = false
            createAccountErrorCode = 4
        }
        
        return passIsValid
    }
}

//struct LogIn_Previews: PreviewProvider {
//    static var previews: some View {
//        LogIn()
//    }
//}
