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
    
    @StateObject private var vm = GameMapVM()
    
    //@State var guessText: String = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //TODO: //This is causing the PURPLE modifying view warning !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    var body: some View {
        ZStack {
            VStack {
                MapView(coordinate:
                    CLLocationCoordinate2D(
                        latitude: roundInfo.locations[roundInfo.roundNumber].lat,
                        longitude: roundInfo.locations[roundInfo.roundNumber].lng),
                        pinLocations: InitPinLocations()
                )
                .ignoresSafeArea(edges: .top)
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
                                        Text("Give Up").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    }.padding(.bottom)
                                }
                            }.onTapGesture {
                                if(vibOn){
                                    let generator = UIImpactFeedbackGenerator(style: .light)
                                    generator.impactOccurred()
                                }
                                roundInfo.answers[roundInfo.roundNumber] =  true //so the last round will show on end game, may need to change this later
                                roundInfo.roundNumbers[roundInfo.roundNumber] = roundInfo.roundNumber
                                roundInfo.times[roundInfo.roundNumber] = -1
                                coordinator.show(EndGame.self)
                            }
                        }
                    }
                }
                
                VStack{
                    HStack{
                        //MARK: Fill The Blank --------------------------------------------------
                        if(gameInfo.multiChoice == false){ //if mode is typing
                            TextField("Answer...",text: $vm.guessText)
                                .font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                .lineLimit(1)
                                .frame(height: 30)
                                .background(CustomColor.trim)
                                .rotationEffect(.degrees(vm.animationAmount[4]))
                                .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: vm.animationAmount[4])
                                .onSubmit{
                                    vm.ValidateAnswer(guessIn: vm.guessText)
                                }.padding(.leading)
                                .onChange(of: vm.animate[4]){ newValue in
                                    vm.animationAmount[4] -= 1
                                }
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 100, height: 30)
                                    .shadow(color: .black, radius: 3, x: 2, y: 2)
                                Text("Give Up").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                            }.onTapGesture {
                                if(vibOn){
                                    let generator = UIImpactFeedbackGenerator(style: .light)
                                    generator.impactOccurred()
                                }
                                roundInfo.answers[roundInfo.roundNumber] =  true //so the last round will show on end game, may need to change this later
                                roundInfo.roundNumbers[roundInfo.roundNumber] = roundInfo.roundNumber
                                roundInfo.times[roundInfo.roundNumber] = -1
                                coordinator.show(EndGame.self)
                            }
                        } else{
                            //MARK: MultiChoice -----------------------------------------------------
                            VStack{
                                HStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                                            .rotationEffect(.degrees(vm.animationAmount[0]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: vm.animationAmount[0])
                                        Text("\(vm.options[0])").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    }
                                    .onTapGesture {
                                        vm.ValidateAnswerMultiChoice(guessIn: vm.options[0], optionClicked: 0)
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
                                    }.onTapGesture {
                                        vm.ValidateAnswerMultiChoice(guessIn: vm.options[1], optionClicked: 1)
                                    }
                                    .onChange(of: vm.animate[1]){ newValue in
                                        vm.animationAmount[1] -= 1
                                    }
                                }
                                HStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                                            .rotationEffect(.degrees(vm.animationAmount[2]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: vm.animationAmount[2])
                                        Text("\(vm.options[2])").font(.custom(Const.fontNormalText, size: Const.fontSizeNormStd))
                                    }.onTapGesture {
                                        vm.ValidateAnswerMultiChoice(guessIn: vm.options[2], optionClicked: 2)
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
                                    }.onTapGesture {
                                        vm.ValidateAnswerMultiChoice(guessIn: vm.options[3], optionClicked: 3)
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
                }.padding(.leading)
                Spacer()
//                ZStack{
//                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
//                        .frame(width: 80, height: 30)
//                    Text("\(count)").onReceive(timer){ _ in
//                        count += 1
//                    }
//                }.padding(.trailing)
                TimerView()
            }.safeAreaInset(edge: .bottom){
                
            }
        }.background(CustomColor.secondary)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            vm.GetInfo(gameInfo: gameInfo, roundInfo: roundInfo, coordinator: coordinator, vibOn: vibOn, volume: volume)
            if(gameInfo.multiChoice == true){
                vm.GetOption()
            }
            if(roundInfo.roundNumber == 0 ){ 
                vm.PlayBackground()
            }
        }
        .onReceive(timer){ _ in
            vm.count += 1
        }
    }//TODO: add Animation to view load / disapear ? 
    func InitPinLocations() -> Array <PinLocation>{
        var pinLocations = [PinLocation]()
        var pinLocation = PinLocation(name: "", coordinate: CLLocationCoordinate2D(
            latitude: 0.0, longitude: 0.0))
        
        for i in 0...roundInfo.roundNumber{
            //var pinLocation: PinLocation
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
