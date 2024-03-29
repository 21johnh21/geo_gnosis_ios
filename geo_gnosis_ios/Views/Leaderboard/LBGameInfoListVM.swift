//
//  LBGameInfoListVM.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/7/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class LBGameInfoListVM: ObservableObject{
    
    @AppStorage("userName") var userNameSt: String = ""
    @AppStorage("userID") var userIDSt: String = ""
    
    @Published var lbData = [LBData]()
    
    private var db = Firestore.firestore()
    
    @Published var fieldDiff: String = String()
    @Published var fieldRegMode: String = String()
    @Published var fieldMultiChoice: Bool = Bool()
    
    func GetData(){
        let db = Firestore.firestore()
        db.collection(Const.dbScoreCollection).whereField("difficulty", isEqualTo: fieldDiff).whereField("regionMode", isEqualTo: fieldRegMode).whereField("multiChoice", isEqualTo: fieldMultiChoice).order(by: "finalScore", descending: true).limit(to: 5).addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            self.lbData = documents.compactMap{ (queryDocumentSnapshot) -> LBData? in
                return try? queryDocumentSnapshot.data(as: LBData.self)
            }
        }
    }
    func SetFields(fieldDiff: String, fieldRegMode: String, fieldMultiChoice: Bool){
        self.fieldDiff = fieldDiff
        self.fieldRegMode = fieldRegMode
        self.fieldMultiChoice = fieldMultiChoice
    }
}
