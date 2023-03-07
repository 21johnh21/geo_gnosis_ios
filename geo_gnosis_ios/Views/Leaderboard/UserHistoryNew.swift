//
//  UserHistory.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/6/23.
//

import SwiftUI

struct UserHistory: View {
    @ObservedObject private var viewModel = UserHistoryVM()
    
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 80)
                Text("User History").font(.custom("BebasNeue-Regular", size: 45)).padding(.top).padding(.top)
            }
            ScrollView{
                ForEach(viewModel.lbData) { lbData in
                    UserHistoryCard(lbData: lbData)
                }
            }
        }.background(CustomColor.secondary)
        .onAppear(){
            self.viewModel.GetData()
        }
        
//        NavigationView{
//            Text("Test View")
//            List(viewModel.lbData){lbData in
//                VStack{
//                    Text("\(lbData.userName)")
//                }
//            }
//        }.onAppear(){
//            self.viewModel.GetData()
//        }
    }
}

struct UserHistory2_Previews: PreviewProvider {
    static var previews: some View {
        UserHistory()
    }
}

