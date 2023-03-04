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
    @AppStorage("sateliteMapOn") var sateliteMapOn: Bool = false
    //@AppStorage("loggedIn") var loggedIn: Bool = false
    @AppStorage("darkMode") var darkMode: Bool = false
    @AppStorage("postScores") var postScores: Bool = true
    
    @State var guess: String = ""
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var roundInfo : RoundInfo
    @EnvironmentObject var gameInfo: GameInfo
    
    @State var options: [String] = ["", "", "", ""]
    @State var count: Int = 0
    @State var multiChoiceAnsers: [String] = [String]()

    @State var animate : [Bool] = [false, false, false, false, false ]
    @State var animationAmount: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]
    
    //var audioPlayer = AVAudioPlayer()
    @State var audioPlayer1:AVAudioPlayer?
    @State var audioPlayer2:AVAudioPlayer?
    @State var audioPlayer3:AVAudioPlayer?
    
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
                                    RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 100, height: 30)
                                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                                    Text("Give Up").font(.custom("Changa-Light", size: 16))
                                }
                            }.onTapGesture {
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
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
                            TextField("Answer...",text: $guess).font(.custom("Changa-Light", size: 16))
                                .background(CustomColor.trim)
                                .rotationEffect(.degrees(animationAmount[4]))
                                .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: animationAmount[4])
                                .onSubmit{
                                    ValidateAnswer(guessB: guess)
                                }.padding(.leading)
                                .onChange(of: animate[4]){ newValue in
                                    animationAmount[4] -= 1
                                }
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 100, height: 30)
                                    .shadow(color: .black, radius: 3, x: 2, y: 2)
                                Text("Give Up").font(.custom("Changa-Light", size: 16))
                            }.onTapGesture {
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
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
                                            .rotationEffect(.degrees(animationAmount[0]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: animationAmount[0])
                                        Text("\(options[0])").font(.custom("Changa-Light", size: 16))
                                    }
                                    .onTapGesture {
                                        ValidateAnswerMultiChoice(guessB: options[0], optionClicked: 0)
                                    }
                                    .onChange(of: animate[0]){ newValue in
                                        animationAmount[0] -= 1
                                    }
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                                            .rotationEffect(.degrees(animationAmount[1]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: animationAmount[1])
                                        Text("\(options[1])").font(.custom("Changa-Light", size: 16))
                                    }.onTapGesture {
                                        ValidateAnswerMultiChoice(guessB: options[1], optionClicked: 1)
                                    }
                                    .onChange(of: animate[1]){ newValue in
                                        animationAmount[1] -= 1
                                    }
                                }
                                HStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                                            .rotationEffect(.degrees(animationAmount[2]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: animationAmount[2])
                                        Text("\(options[2])").font(.custom("Changa-Light", size: 16))
                                    }.onTapGesture {
                                        ValidateAnswerMultiChoice(guessB: options[2], optionClicked: 2)
                                    }
                                    .onChange(of: animate[2]){ newValue in
                                        animationAmount[2] -= 1
                                    }
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                                            .shadow(color: .black, radius: 3, x: 2, y: 2)
                                            .rotationEffect(.degrees(animationAmount[3]))
                                            .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 1,  initialVelocity: 20.0), value: animationAmount[3])
                                        Text("\(options[3])").font(.custom("Changa-Light", size: 16))
                                    }.onTapGesture {
                                        ValidateAnswerMultiChoice(guessB: options[3], optionClicked: 3)
                                    }
                                    .onChange(of: animate[3]){ newValue in
                                        animationAmount[3] -= 1
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
                    Text("Round: \(roundInfo.roundNumber + 1)").font(.custom("Changa-Light", size: 16)) //Round number
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
            if(gameInfo.multiChoice == true){
                GetOption()
            }
            if(roundInfo.roundNumber == 0 ){ //TODO: if muted
                PlayBackground()
            }
        }
        .onReceive(timer){ _ in
            count += 1
        }
    }
    
    //MARK: functions
    func ValidateAnswer (guessB: String) {
        var answer: String
        answer = GetCorrectAnswer()
        
        if(guessB.trimmingCharacters(in: .whitespaces).lowercased()
           == answer.lowercased()
           || AlternativeName(country: answer).contains(guessB)
           || guessB == ""){
            //somehow allow like 2 - 3 charachters mispelling
            
            if(roundInfo.roundNumber == 4){
                CorrectGuess()
                coordinator.show(EndGame.self)
                print("Correct!")
            }else{
                CorrectGuess()
                roundInfo.roundNumber += 1
                coordinator.show(GameMap.self)
                print("Correct!")
            }
        }
        else{
            
            guess = "" //clear text
            //send give user feed back
            //animation
            animationAmount[4] += 1
            animate[4].toggle()
            //sound
            PlayIncorrect()
            //haptic
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
    func AlternativeName(country: String) -> [String]{
        var countryNames = [String]()
        countryNames.append(country)
        switch(country){
        case("United States"):
            countryNames.append("USA")
            countryNames.append("US")
        case("United Kingdom"):
            countryNames.append("UK")
        case("United Arab Emirites"):
            countryNames.append("UAE")
        case("Congo (Kinshasa)"):
            countryNames.append("Congo")
            countryNames.append("DRC")
            
        //... CAR, other congo, macedonia, czechia?, ivory coast, east timor, palestine/isreal?
        // cape verde, bosnia, caribean snts, turkey, taiwan?, new guinea, ...
            
        default:
            break
        }
        return countryNames
    }
    func ValidateAnswerMultiChoice(guessB: String, optionClicked: Int){
        var answer: String
        answer = GetCorrectAnswer()
        
        if(guessB == answer){

            if(roundInfo.roundNumber == 4){
                CorrectGuess()
                coordinator.show(EndGame.self)
                print("Correct!")
            }else{
                CorrectGuess()
                roundInfo.roundNumber += 1
                coordinator.show(GameMap.self)
                print("Correct!")
            }
        }
        else{
            
            guess = "" //clear text
            //send give user feed back
            //animation
            animationAmount[optionClicked] += 1
            animate[optionClicked].toggle()
            //sound
            PlayIncorrect()
            //haptic
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
    func GetOption() {
        //options = roundInfo.multiChoiceOptions[roundInfo.roundNumber]
        for i in 0...3{
            let optionIndex = Int.random(in: 0...3-i)
            
            if(gameInfo.regionMode == "City"){
                options[i] = roundInfo.multiChoiceOptions[roundInfo.roundNumber][optionIndex].city_ascii
            }else if(gameInfo.regionMode == "State"){
                options[i] = roundInfo.multiChoiceOptions[roundInfo.roundNumber][optionIndex].admin_name
            }else{
                options[i] = roundInfo.multiChoiceOptions[roundInfo.roundNumber][optionIndex].country
            }
            roundInfo.multiChoiceOptions[roundInfo.roundNumber].remove(at: optionIndex)
        }
    }
    func CorrectGuess(){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        PlayCorrect()
        if(roundInfo.roundNumber == 4){
            audioPlayer1?.pause()
        }
        roundInfo.times[roundInfo.roundNumber] = count
        //roundInfo.times[roundInfo.roundNumber] =
        roundInfo.roundNumbers[roundInfo.roundNumber] = roundInfo.roundNumber + 1
        roundInfo.answers[roundInfo.roundNumber] = true
    }
//    func MultiChoiceOptionButton(){
//        ZStack{
//            RoundedRectangle(cornerRadius: 5).fill(.green).frame(height: 30)
//            Text("\(options[0])")
//        }
//        .onTapGesture {
//            ValidateAnswerMultiChoice(guessB: options[0])
//        }
//    }
    func GetCorrectAnswer()-> String{
        var answer: String
        
        if(gameInfo.regionMode == "City"){
            answer = roundInfo.locations[roundInfo.roundNumber].city_ascii
        }else if(gameInfo.regionMode == "State"){
            answer = roundInfo.locations[roundInfo.roundNumber].admin_name
        }else{ //World
            answer = roundInfo.locations[roundInfo.roundNumber].country
        }
        
        return answer
    }
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
    func PlayBackground(){
        if let path = Bundle.main.path(forResource: "action-sound-effect", ofType: "mp3"){
            self.audioPlayer1 = AVAudioPlayer()
            //self.isPlaying.toggle()
            let url = URL(fileURLWithPath: path)
            
            do {
                self.audioPlayer1 = try AVAudioPlayer(contentsOf: url)
                audioPlayer1?.volume = Float(volume/100)
                self.audioPlayer1?.prepareToPlay()
                self.audioPlayer1?.numberOfLoops = -1
                self.audioPlayer1?.play()
                //self.audioPlayer1?.numberOfLoops()
            }catch {
                print("Eror")
            }
        }
    }
    func PlayCorrect(){
        if let path = Bundle.main.path(forResource: "Ding-sound-effect", ofType: "mp3"){
            self.audioPlayer2 = AVAudioPlayer()
            //self.isPlaying.toggle()
            let url = URL(fileURLWithPath: path)
            
            do {
                self.audioPlayer2 = try AVAudioPlayer(contentsOf: url)
                audioPlayer2?.volume = Float(volume/100)
                self.audioPlayer2?.prepareToPlay()
                self.audioPlayer2?.play()
            }catch {
                print("Eror")
            }
        }
    }
    func PlayIncorrect(){
        if let path = Bundle.main.path(forResource: "button-click-sound-effect", ofType: "mp3"){
            self.audioPlayer3 = AVAudioPlayer()
            //self.isPlaying.toggle()
            let url = URL(fileURLWithPath: path)
            
            do {
                self.audioPlayer3 = try AVAudioPlayer(contentsOf: url)
                audioPlayer3?.volume = Float(volume/100)
                self.audioPlayer3?.prepareToPlay()
                self.audioPlayer3?.play()
            }catch {
                print("Eror")
            }
        }
    }
}

//struct map_Previews: PreviewProvider {
//    static var previews: some View {
//        GameMap()
//    }
//}
