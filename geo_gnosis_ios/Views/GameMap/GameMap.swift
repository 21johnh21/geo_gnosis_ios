//
//  GameMap.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//
import SwiftUI
import CoreLocation
import AVFAudio

struct GameMap: View {
    
    @AppStorage("vibOn") var vibOn: Bool = true
    @AppStorage("volume") var volume: Double = 100

    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var roundInfo : RoundInfo
    @EnvironmentObject var gameInfo: GameInfo
    @EnvironmentObject var timerGlobal: TimerGlobal
    @EnvironmentObject var audioPlayer: AudioPlayer
    
    @StateObject private var vm = GameMapVM()
    
    @State var mapViewID = 0

    var body: some View {
        ZStack {
            VStack {
                EquatableView(
                    content: MapView(coordinate:
                    CLLocationCoordinate2D(
                        latitude: roundInfo.locations[roundInfo.roundNumber].lat,
                        longitude: roundInfo.locations[roundInfo.roundNumber].lng),
                        pinLocations: initPinLocations()
                                    )).id(mapViewID)
                    .onAppear(){
                        timerGlobal.penalty = false
                        mapViewID += 1
                    }
                .overlay(){
                    VStack {
                        Spacer()
                        HStack{
                            Spacer()
                            if(gameInfo.multiChoice){
                                Button(action: {
                                    PlayDefaultFeedback().play()
                                    vm.skipRound()
                                }) {
                                    HStack(spacing: 6) {
                                        Image(systemName: "forward.fill")
                                            .font(.system(size: Const.fontSizeNormStd - 2))
                                        Text("Skip")
                                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                            .fontWeight(.semibold)
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .fill(.red.opacity(0.9))
                                            .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                                    )
                                }
                                .padding(.bottom, 16)
                                .padding(.trailing, 16)
                            }
                        }
                    }
                }
                
                VStack{
                    HStack{
                        //MARK: Fill The Blank --------------------------------------------------
                        if(gameInfo.multiChoice == false){ //if mode is typing
                            HStack(spacing: 12) {
                                TextField("Enter your answer...", text: $vm.guessText)
                                    .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .fill(CustomColor.primary)
                                            .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                                    )
                                    .autocorrectionDisabled()
                                    .textInputAutocapitalization(.words)
                                    .submitLabel(.done)
                                    .rotationEffect(.degrees(vm.animationAmount[4]))
                                    .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: vm.animationAmount[4])
                                    .onSubmit{
                                        vm.validateAnswer(guessIn: vm.guessText)
                                    }
                                    .onChange(of: vm.animate[4]){ newValue in
                                        vm.animationAmount[4] -= 1
                                    }

                                Button(action: {
                                    PlayDefaultFeedback().play()
                                    vm.skipRound()
                                }) {
                                    HStack(spacing: 6) {
                                        Image(systemName: "forward.fill")
                                            .font(.system(size: Const.fontSizeNormStd - 2))
                                        Text("Skip")
                                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                            .fontWeight(.semibold)
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .fill(.red.opacity(0.9))
                                            .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                                    )
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.bottom, 12)
                        } else{
                            //MARK: MultiChoice -----------------------------------------------------
                            VStack(spacing: 8){
                                HStack(spacing: 8){
                                    Button(action: {
                                        vm.validateAnswerMultiChoice(guessIn: vm.options[0], optionClicked: 0)
                                    }) {
                                        Text("\(vm.options[0])")
                                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                            .fontWeight(.medium)
                                            .foregroundColor(.primary)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 12)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                                    .fill(CustomColor.primary)
                                                    .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                                            )
                                            .rotationEffect(.degrees(vm.animationAmount[0]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: vm.animationAmount[0])
                                    }
                                    .onChange(of: vm.animate[0]){ newValue in
                                        vm.animationAmount[0] -= 1
                                    }

                                    Button(action: {
                                        vm.validateAnswerMultiChoice(guessIn: vm.options[1], optionClicked: 1)
                                    }) {
                                        Text("\(vm.options[1])")
                                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                            .fontWeight(.medium)
                                            .foregroundColor(.primary)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 12)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                                    .fill(CustomColor.primary)
                                                    .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                                            )
                                            .rotationEffect(.degrees(vm.animationAmount[1]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: vm.animationAmount[1])
                                    }
                                    .onChange(of: vm.animate[1]){ newValue in
                                        vm.animationAmount[1] -= 1
                                    }
                                }
                                HStack(spacing: 8){
                                    Button(action: {
                                        vm.validateAnswerMultiChoice(guessIn: vm.options[2], optionClicked: 2)
                                    }) {
                                        Text("\(vm.options[2])")
                                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                            .fontWeight(.medium)
                                            .foregroundColor(.primary)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 12)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                                    .fill(CustomColor.primary)
                                                    .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                                            )
                                            .rotationEffect(.degrees(vm.animationAmount[2]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: vm.animationAmount[2])
                                    }
                                    .onChange(of: vm.animate[2]){ newValue in
                                        vm.animationAmount[2] -= 1
                                    }

                                    Button(action: {
                                        vm.validateAnswerMultiChoice(guessIn: vm.options[3], optionClicked: 3)
                                    }) {
                                        Text("\(vm.options[3])")
                                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                            .fontWeight(.medium)
                                            .foregroundColor(.primary)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 12)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                                    .fill(CustomColor.primary)
                                                    .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                                            )
                                            .rotationEffect(.degrees(vm.animationAmount[3]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: vm.animationAmount[3])
                                    }
                                    .onChange(of: vm.animate[3]){ newValue in
                                        vm.animationAmount[3] -= 1
                                    }
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.bottom, 12)
                        }
                        //MARK: End MultiChoice ---------------------------------------------------------
                    }
                }
            }
            HStack {
                // Round indicator
                HStack(spacing: 6) {
                    Image(systemName: "flag.fill")
                        .font(.system(size: Const.fontSizeNormStd - 2))
                        .foregroundColor(.primary)
                    Text("Round \(roundInfo.roundNumber + 1)")
                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(CustomColor.primary)
                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                )
                .padding(.leading, 12)
                .padding(.top, 12)

                Spacer()

                // Guess the X
                HStack(spacing: 6) {
                    let icon = gameInfo.regionMode == Const.modeRegCountryText ? "globe" : (gameInfo.regionMode == Const.modeRegRegionText ? "building.2" : "building.2.fill")
                    Image(systemName: icon)
                        .font(.system(size: Const.fontSizeNormStd - 2))
                        .foregroundColor(.primary)
                    Text("Guess the \(gameInfo.regionMode)")
                        .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(CustomColor.primary)
                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                )
                .padding(.top, 12)

                Spacer()

                TimerView().padding(.top, 12)
            }.safeAreaInset(edge: .bottom){

            }
            
            if((vm.showPenalty || (timerGlobal.penalty)) && timerGlobal.timerGlobal > 0){
                Penalty(penaltyAmount: vm.penaltyAmount > 0 ? vm.penaltyAmount : 5).id(vm.viewID)
            }

            // Success Animation
            if vm.showSuccess {
                ZStack {
                    Color.green.opacity(0.3)
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.green)
                            .scaleEffect(vm.showSuccess ? 1.0 : 0.5)
                            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: vm.showSuccess)

                        Text("Correct!")
                            .font(.custom(Const.fontTitle, size: Const.fontSizeTitleLrg))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(40)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.green)
                            .shadow(color: .black.opacity(0.3), radius: 20)
                    )
                }
                .transition(.opacity)
            }

            // Error Animation
            if vm.showError {
                ZStack {
                    Color.red.opacity(0.2)
                        .ignoresSafeArea()

                    VStack(spacing: 16) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.red)
                            .scaleEffect(vm.showError ? 1.0 : 0.5)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: vm.showError)

                        Text("Try Again!")
                            .font(.custom(Const.fontNormalText, size: Const.fontSizeNormLrg))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(30)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.red)
                            .shadow(color: .black.opacity(0.3), radius: 15)
                    )
                }
                .transition(.opacity)
            }
        }
        .background(alignment: .center){BackgroundView()}
        .navigationBarBackButtonHidden(true)
        .onAppear{
            vm.getInfo(gameInfo: gameInfo, roundInfo: roundInfo, coordinator: coordinator, vibOn: vibOn, volume: volume, timerGlobal: timerGlobal, audioPlayer: audioPlayer)
            vm.setUpView()
        }
    }
    func initPinLocations() -> Array <PinLocation>{
        var pinLocations = [PinLocation]()
        var pinLocation = PinLocation(name: "", coordinate: CLLocationCoordinate2D(
            latitude: 0.0, longitude: 0.0))

        // Guard against accessing beyond available locations
        let maxIndex = min(roundInfo.roundNumber, roundInfo.locations.count - 1)
        guard maxIndex >= 0, !roundInfo.locations.isEmpty else {
            return pinLocations
        }

        for i in 0...maxIndex{
            pinLocation.coordinate = CLLocationCoordinate2D(
                latitude: roundInfo.locations[i].lat, longitude: roundInfo.locations[i].lng)
            pinLocation.name=""
            pinLocations.append(pinLocation)
        }
        return pinLocations
    }
}

//struct map_Previews: PreviewProvider {
//    static var previews: some View {
//        GameMap()
//    }
//}
