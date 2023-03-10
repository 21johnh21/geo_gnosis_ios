//
//  SignInWithApple.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/10/23.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth
import CryptoKit

struct SignInWithApple: View {
    
    @State var currentNonce: String?
    @State var displayName: String?
    
    var appleLogInButton = ASAuthorizationAppleIDButton()
    
    var body: some View {
        SignInWithAppleButton(.signIn, onRequest: onRequest, onCompletion: onCompletion)
            .signInWithAppleButtonStyle(.black)
            .frame(width: 200, height: 50)
    }
    private func onRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    private func onCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success (let authResults):
            guard let credential = authResults.credential
                    as? ASAuthorizationAppleIDCredential
            else { return }
            let storedName = credential.fullName?.givenName ?? ""
            let storedEmail = credential.email ?? ""
            let userID = credential.user
            print("Apple Creds: \(storedName) - \(storedEmail) - \(userID)")
        case .failure (let error):
            print("Authorization failed: " + error.localizedDescription)
        }
    }
}
struct SignInWithApple_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithApple()
    }
}
