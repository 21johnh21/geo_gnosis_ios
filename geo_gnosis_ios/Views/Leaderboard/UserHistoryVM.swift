//
//  UserHistoryVM.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/6/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserHistoryVM: ObservableObject{
    
    @AppStorage("userName") var userNameSt: String = ""
    @AppStorage("userID") var userIDSt: String = ""
    
    @Published var lbData = [LBData]()
    
    private var db = Firestore.firestore()
    
    func GetData(){
        let db = Firestore.firestore()
        //TODO: orderby date 
        db.collection(Const.dbScoreCollection).whereField("userName", isEqualTo: userNameSt).addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            self.lbData = documents.compactMap{ (queryDocumentSnapshot) -> LBData? in
                return try? queryDocumentSnapshot.data(as: LBData.self)
            }
        }
    }
}
