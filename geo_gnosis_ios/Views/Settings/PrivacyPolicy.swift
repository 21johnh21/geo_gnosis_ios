//
//  PrivacyPolicy.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/11/23.
//

import SwiftUI

struct PrivacyPolicy: View {
    var body: some View {
        VStack{
            Image(systemName: "chevron.down")// on drag down close
            Text("Privacy Policy")
            Text("Geo Gnosis does not collect any personal information from any of your use of our Apps. If we have any of your personal information we will not willingly sell or give it to anyone, except if lawfully subpoenaed to produce it and then only after offering you a reasonable chance to challenge such subpoena if allowed by law.").padding()
        }.background(){
            RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).shadow(radius: 10)
        }
        .onDrag(){
            NSItemProvider(object: UIImage(systemName: "mustache")!)
        }
    }
}

struct PrivacyPolicy_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicy()
    }
}
