//
//  GameMap.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 1/22/23.
//
import SwiftUI
import CoreLocation

struct GameMap: View {
    
    @State var guess: String = ""
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject var roundInfo : RoundInfo
    @EnvironmentObject var gameInfo: GameInfo
    
    @State var options: [String] = ["", "", "", ""]
    @State var count: Int = 0
    @State var multiChoiceAnsers: [String] = [String]()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

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
                                RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 100, height: 30)
                                Text("Give Up")
                            }.onTapGesture {
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
                        //MARK: Fill The Blank
                        if(gameInfo.multiChoice == false){ //if mode is typing
                            TextField("Answer...",text: $guess)
                                .onSubmit{
                                    ValidateAnswer(guessB: guess)
                                }.padding(.leading)
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 5).fill(.red).frame(width: 100, height: 30)
                                Text("Give Up")
                            }.onTapGesture {
                                roundInfo.answers[roundInfo.roundNumber] =  true //so the last round will show on end game, may need to change this later
                                roundInfo.roundNumbers[roundInfo.roundNumber] = roundInfo.roundNumber
                                roundInfo.times[roundInfo.roundNumber] = -1
                                coordinator.show(EndGame.self)
                            }
                        } else{
                            //MARK: MultiChoice
                            VStack{
                                HStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                                        Text("\(options[0])")
                                    }
                                    .onTapGesture {
                                        ValidateAnswerMultiChoice(guessB: options[0])
                                    }
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                                        Text("\(options[1])")
                                    }.onTapGesture {
                                        ValidateAnswerMultiChoice(guessB: options[1])
                                    }
                                }
                                HStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                                        Text("\(options[2])")
                                    }.onTapGesture {
                                        ValidateAnswerMultiChoice(guessB: options[2])
                                    }
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary).frame(height: 30)
                                        Text("\(options[3])")
                                    }.onTapGesture {
                                        ValidateAnswerMultiChoice(guessB: options[3])
                                    }
                                }
                            }
                        }
                        //MARK: End MultiChoice
                    }
                }
            }

            HStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                        .frame(width: 80, height: 30)
                    Text("Round: \(roundInfo.roundNumber + 1)") //Round number
                }.padding(.leading)
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(CustomColor.primary)
                        .frame(width: 80, height: 30)
                    Text("\(count)").onReceive(timer){ _ in
                        count += 1
                    }
                }.padding(.trailing)
            }.safeAreaInset(edge: .bottom){
                
            }
        }.background(CustomColor.secondary)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            if(gameInfo.multiChoice == true){
                GetOption()
            }
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
            //sound
            //haptic
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
    func ValidateAnswerMultiChoice(guessB: String){
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
            //sound
            //haptic
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
        roundInfo.times[roundInfo.roundNumber] = count
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
}

//struct map_Previews: PreviewProvider {
//    static var previews: some View {
//        GameMap()
//    }
//}
