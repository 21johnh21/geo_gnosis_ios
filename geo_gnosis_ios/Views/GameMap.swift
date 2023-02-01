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
    
    @State var count: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            VStack {
                MapView(coordinate:
                            CLLocationCoordinate2D(
                                latitude: roundInfo.locations[roundInfo.roundNumber].lat,
                                longitude: roundInfo.locations[roundInfo.roundNumber].lng)
                )
                .ignoresSafeArea(edges: .top)
                
                VStack{
                    HStack{
                        Spacer()
                    }
                    HStack{
                        if(gameInfo.multiChoice == false){ //if mode is typing
                            TextField("Answer...",text: $guess)
                                .onSubmit{
                                    ValidateAnswer(guessB: guess, answer: roundInfo.locations[roundInfo.roundNumber].country)
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
                            //mode is multi choice
                            //NEED TO ADD give up button
                            VStack{
                                HStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(.green).frame(height: 30)
                                        //choose random option
                                        let optionIndex = Int.random(in: 0..<gameInfo.multiChoiceOptions.count)
                                        let option = gameInfo.multiChoiceOptions[optionIndex]
                                        
                                        Text("\(option)")
                                    }.onTapGesture {
                                        //choose random option
                                        let optionIndex = Int.random(in: 0..<gameInfo.multiChoiceOptions.count)
                                        let option = gameInfo.multiChoiceOptions[optionIndex]
                                        //remove that option from array
                                        //validate answer
                                    }
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(.green).frame(height: 30)
                                        Text("Choice 2")
                                    }.onTapGesture { }
                                }
                                HStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(.green).frame(height: 30)
                                        Text("Choice 3")
                                    }.onTapGesture { }
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5).fill(.green).frame(height: 30)
                                        Text("Choice 4")
                                    }.onTapGesture { }
                                }
                            }
                        }
                    }
                }
            }
            HStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green)
                        .frame(width: 80, height: 30)
                    Text("Round: \(roundInfo.roundNumber + 1)") //Round number
                }.padding(.leading)
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 5).fill(.green)
                        .frame(width: 80, height: 30)
                    Text("\(count)").onReceive(timer){ _ in
                        count += 1
                    }
                }.padding(.trailing)
            }.safeAreaInset(edge: .bottom){
                
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    func ValidateAnswer (guessB: String, answer: String) {
        if(guessB.trimmingCharacters(in: .whitespaces).lowercased()
           == answer.lowercased()
           || AlternativeName(country: answer).contains(guessB)
           || guessB == ""){
            // make a method to check if the guess is equall to an aleternative name or acrynmy for the country
            //somehow allow like 2 - 3 charachters mispelling
            
            if(roundInfo.roundNumber == 4){
                roundInfo.times[roundInfo.roundNumber] = count
                roundInfo.roundNumbers[roundInfo.roundNumber] = roundInfo.roundNumber + 1
                roundInfo.answers[roundInfo.roundNumber] = true
                coordinator.show(EndGame.self)
                print("Correct!")
            }else{
                roundInfo.times[roundInfo.roundNumber] = count
                roundInfo.roundNumbers[roundInfo.roundNumber] = roundInfo.roundNumber + 1
                roundInfo.answers[roundInfo.roundNumber] = true
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
    func ChooseMultiChoices(gameMode: String) -> [String]{
        var multiChoices = [String]()
        
        //i need to figure out how to get this data, for country I could include a json of just countries
        //but I dont think that will work, it would probably be best to make an array depending on the mode
        //in LocationsData then access it here
        //it would be nice to have some logic to detirmine if the locations are similar to eachother
        // maybe base it on distance for the correct answer? that may cause problems though
        
//        switch(gameMode){
//        case("country"):
//        case("state"):
//        case("city"):
//        }
        
        return multiChoices
    }
}

struct map_Previews: PreviewProvider {
    static var previews: some View {
        GameMap()
    }
}
