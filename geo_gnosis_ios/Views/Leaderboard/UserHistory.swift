//
//  UserHistory.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/4/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct UserHistory: View {
    
    @AppStorage("userName") var userNameSt: String = ""
    @AppStorage("userID") var userIDSt: String = ""
    
    var body: some View {
        ScrollView{
            
        }.onAppear(){
            GetData()
        }
    }
    func GetData(){
        let db = Firestore.firestore()
        let docRef = db.collection("Score Collection").whereField("userName", isEqualTo: "DEV_JH")
        
//        docRef.getDocument(as: LBInfo) { result in
//            // The Result type encapsulates deserialization errors or
//            // successful deserialization, and can be handled as follows:
//            //
//            //      Result
//            //        /\
//            //   Error  City
//            switch result {
//            case .success(let city):
//                // A `City` value was successfully initialized from the DocumentSnapshot.
//                print("City: \(city)")
//            case .failure(let error):
//                // A `City` value could not be initialized from the DocumentSnapshot.
//                print("Error decoding city: \(error)")
//            }
//        }
        
        //order data here, or maybe I can do that on the backend
        //query data that meets criteria for each category
        
//        db.collection("Score Collection").whereField("userName", isEqualTo: "DEV_JH")
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//                    }
//                }
//        }
        
    }
}

struct UserHistory_Previews: PreviewProvider {
    static var previews: some View {
        UserHistory()
    }
}
