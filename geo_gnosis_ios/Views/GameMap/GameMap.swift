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
                            ZStack{
                                if(gameInfo.multiChoice){
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 100, height: 30)
                                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                                        Text("Skip").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    }.padding(.bottom)
                                }
                            }.onTapGesture {
                                PlayDefaultFeedback().play()
                                vm.skipRound()
                            }
                        }
                    }
                }
                
                VStack{
                    HStack{
                        //MARK: Fill The Blank --------------------------------------------------
                        if(gameInfo.multiChoice == false){ //if mode is typing
                            ZStack{
                            RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                                    .frame(height: 30)
                                    .padding(.leading)
                            TextField("Answer...",text: $vm.guessText)
                                .background(CustomColor.primary)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.words)
                                .submitLabel(.done)
                                .rotationEffect(.degrees(vm.animationAmount[4]))
                                .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: vm.animationAmount[4])
                                .onSubmit{
                                    vm.validateAnswer(guessIn: vm.guessText)
                                }.padding(.leading)
                                .onChange(of: vm.animate[4]){ newValue in
                                    vm.animationAmount[4] -= 1
                                }
                            }
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 100, height: 30)
                                    .shadow(color: .black, radius: 3, x: 2, y: 2)
                                Text("Skip").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)).padding(.trailing)
                            }.onTapGesture {
                                PlayDefaultFeedback().play()
                                vm.skipRound()
                            }
                        } else{
                            //MARK: MultiChoice -----------------------------------------------------
                            VStack(spacing: 0){
                                HStack(spacing: 0){
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                                            .rotationEffect(.degrees(vm.animationAmount[0]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: vm.animationAmount[0])
                                        Text("\(vm.options[0])").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    }.padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                    .onTapGesture {
                                        vm.validateAnswerMultiChoice(guessIn: vm.options[0], optionClicked: 0)
                                    }
                                    .onChange(of: vm.animate[0]){ newValue in
                                        vm.animationAmount[0] -= 1
                                    }
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                                            .rotationEffect(.degrees(vm.animationAmount[1]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: vm.animationAmount[1])
                                        Text("\(vm.options[1])").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    }.padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                    .onTapGesture {
                                        vm.validateAnswerMultiChoice(guessIn: vm.options[1], optionClicked: 1)
                                    }
                                    .onChange(of: vm.animate[1]){ newValue in
                                        vm.animationAmount[1] -= 1
                                    }
                                }
                                HStack(spacing: 0){
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                                            .rotationEffect(.degrees(vm.animationAmount[2]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: vm.animationAmount[2])
                                        Text("\(vm.options[2])").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    }.padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                    .onTapGesture {
                                        vm.validateAnswerMultiChoice(guessIn: vm.options[2], optionClicked: 2)
                                    }
                                    .onChange(of: vm.animate[2]){ newValue in
                                        vm.animationAmount[2] -= 1
                                    }
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                                            .rotationEffect(.degrees(vm.animationAmount[3]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: vm.animationAmount[3])
                                        Text("\(vm.options[3])").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    }.padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                    .onTapGesture {
                                        vm.validateAnswerMultiChoice(guessIn: vm.options[3], optionClicked: 3)
                                    }
                                    .onChange(of: vm.animate[3]){ newValue in
                                        vm.animationAmount[3] -= 1
                                    }
                                }
                            }
                        }
                        //MARK: End MultiChoice ---------------------------------------------------------
                    }
                }
            }
            HStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                        .frame(width: 80, height: 30)
                    Text("Round: \(roundInfo.roundNumber + 1)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)) //Round number
                }.padding(.leading).padding(.top)
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                        .frame(width: 160, height: 30)
                    Text("Guess the \(gameInfo.regionMode)").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd)) //Round number
                }.padding(.top)
                Spacer()
                TimerView().padding(.top)
            }.safeAreaInset(edge: .bottom){
                
            }
            
            if((vm.showPenalty || (timerGlobal.penalty)) && timerGlobal.timerGlobal > 0){
                Penalty(penaltyAmount: vm.penaltyAmount > 0 ? vm.penaltyAmount : 5).id(vm.viewID)
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
