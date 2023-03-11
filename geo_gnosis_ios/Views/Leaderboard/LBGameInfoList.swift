//
//  LBGameInfoList.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/10/23.
//

import SwiftUI

struct LBGameInfoList: View {
    var multiChoice: Bool
    var gameMode: String
    var gameDiff: String
    
    @ObservedObject private var viewModel = LBGameInfoListVM()
    
    var body: some View {
        VStack{
            ForEach(viewModel.lbData) { lbData in
                UserHistoryCard(lbData: lbData)
            }
        }.onAppear(){
            self.viewModel.SetFields(fieldDiff: gameDiff, fieldRegMode: gameMode, fieldMultiChoice: multiChoice)
            self.viewModel.GetData()
        }
    }
}

struct LBGameInfoList_Previews: PreviewProvider {
    static var previews: some View {
        LBGameInfoList(multiChoice: true, gameMode: "World", gameDiff: "Easy")
    }
}
