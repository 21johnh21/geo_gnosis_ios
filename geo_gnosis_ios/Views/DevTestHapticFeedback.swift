//
//  DevTestHapticFeedback.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 2/20/23.
//

import SwiftUI

struct DevTestHapticFeedback: View {
    //@State var response : String = ""
    var body: some View {
        var count : Int = 1
        var response : String = ""
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                VStack{
                    Text("DEV - Test Haptic")
                    Text("type: \(response)")
                }
            }.onTapGesture {
                Alert(title: Text(giveFeedback(i: count)))
                count = count + 1
            }
            ZStack{
                RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                VStack{
                    Text("Reset")
                }
            }.onTapGesture {
               count = 1
            }
        }
    }
    func giveFeedback(i: Int) -> String{
        var typeText: String = ""
               print("Running \(i)")

               switch i {
               case 1:
                   let generator = UINotificationFeedbackGenerator()
                   generator.notificationOccurred(.error)
                   typeText = "notificationOccurred(.error)"
               case 2:
                   let generator = UINotificationFeedbackGenerator()
                   generator.notificationOccurred(.success)
                   typeText = "notificationOccurred(.success)"
               case 3:
                   let generator = UINotificationFeedbackGenerator()
                   generator.notificationOccurred(.warning)
                   typeText = "notificationOccurred(.warning)"
               case 4:
                   let generator = UIImpactFeedbackGenerator(style: .light)
                   generator.impactOccurred()
                   typeText = "UIImpactFeedbackGenerator(style: .light)"
               case 5:
                   let generator = UIImpactFeedbackGenerator(style: .medium)
                   generator.impactOccurred()
                   typeText = "UIImpactFeedbackGenerator(style: .medium)"
               case 6:
                   let generator = UIImpactFeedbackGenerator(style: .heavy)
                   generator.impactOccurred()
                   typeText = "UIImpactFeedbackGenerator(style: .heavy)"
               default:
                   let generator = UISelectionFeedbackGenerator()
                   generator.selectionChanged()
                   typeText = "selectionChanged"
               }
        return typeText
    }
}

struct DevTestHapticFeedback_Previews: PreviewProvider {
    static var previews: some View {
        DevTestHapticFeedback()
    }
}
