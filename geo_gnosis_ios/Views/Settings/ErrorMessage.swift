//
//  ErrorMessage.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/25/23.
//

import SwiftUI

struct ErrorMessage: View {
    @Binding var createAccountErrorCode: Int
    var body: some View {
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
    }
}

//struct ErrorMessage_Previews: PreviewProvider {
//    static var previews: some View {
//        ErrorMessage(createAccountErrorCode: 0)
//    }
//}
