//
//  CreateAccount.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/10/23.
//

import SwiftUI
import FirebaseAuth

struct CreateAccount: View {
    
    @AppStorage("userName") var userNameSt: String = ""
    @AppStorage("userID") var userIDSt: String = ""
    
    @State var userName: String = ""
    @State var password: String = ""
    @State var passwordCon: String = ""
    @State var email: String = ""
    @State var hadErrorCreatingAccount: Bool = false
    @State var createAccountErrorCode: Int = 0 //no error = 0
    @State var user: User?
    
    var body: some View {
        VStack{
            Text("Create and Account")
            HStack{
                Text("User Name: ")
                TextField("User Name", text: $userName).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            HStack{
                Text("Email: ")
                TextField("user@sample.com", text: $email).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            SecureInputView("Password", text: $password)
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
            SecureInputView("Password", text: $passwordCon)
            ZStack{
                RoundedRectangle(cornerRadius: 5).fill(.green).frame(width: 150, height: 30)
                Text("Create Account")
            }.onTapGesture {
                CreateAccWithEmailAndPass()
            }
        }.padding().background(){
            RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
        }
        .overlay(){
            RoundedRectangle(cornerRadius: 5).stroke( .gray, lineWidth: 2)
        }
    }
    func CreateAccWithEmailAndPass(){
        
        if(PassIsValid()){
            
            Auth.auth().createUser(withEmail: email, password: password) { user, error in
                if error == nil && user != nil {
                    print("User created!")
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = userName
                    
                    changeRequest?.commitChanges { error in
                        if error == nil {
                            print("User display name changed!")
                            callSignIn()
                            //self.dismiss(animated: false, completion: nil)
                        } else {
                            print("Error: \(error!.localizedDescription)")
                        }
                    }
                    
                } else {
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
            userIDSt = currentUser?.uid ?? ""
            userNameSt = currentUser?.displayName ?? ""
        }
    }
    func PassIsValid() -> Bool{
        
        var passIsValid: Bool = true
        
        let capREGEX = ".*[A-Z]+.*"
        let lowREGEX = ".*[a-z]+.*"
        let numREGEX = ".*[0-9]+.*"
        let spcREGEX = ".*[!&^%$#@()/]+.*"
        
        var testREGEX = NSPredicate(format:"SELF MATCHES %@", capREGEX)
        let hasCap = testREGEX.evaluate(with: password)
        
        testREGEX = NSPredicate(format:"SELF MATCHES %@", lowREGEX)
        let hasLow = testREGEX.evaluate(with: password)
        
        testREGEX = NSPredicate(format:"SELF MATCHES %@", numREGEX)
        let hasNum = testREGEX.evaluate(with: password)
        
        testREGEX = NSPredicate(format:"SELF MATCHES %@", spcREGEX)
        let hasSpc = testREGEX.evaluate(with: password)
        
        createAccountErrorCode = 0
        
        if(!(password == passwordCon)){ //pass + con pass dont match
            passIsValid = false
            createAccountErrorCode = 5
        }else if(password.count < 9){ // less than 8 chars
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
            print("Error: \(error.localizedDescription)")
        }
    }
    func callSignIn() {
        Task{
            await SignInWithEmailAndPass()
        }
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
    }
}
