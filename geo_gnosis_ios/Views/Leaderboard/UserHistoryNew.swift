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
        NavigationView{
            Text("Test View")
            List(viewModel.lbData){lbData in
                VStack{
                    Text("\(lbData.userName)")
                }
            }
        }.onAppear(){
            self.viewModel.GetData()
        }
    }
}

struct UserHistory2_Previews: PreviewProvider {
    static var previews: some View {
        UserHistory()
    }
}

