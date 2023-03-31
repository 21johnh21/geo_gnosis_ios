//
//  GameMapVM.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/12/23.
//

import Foundation
import CoreLocation
import AVFAudio
import UIKit



extension GameMap{
    @MainActor class GameMapVM: ObservableObject{
        
        @Published var guessText: String = ""
        
        @Published var options: [String] = ["", "", "", ""]
        @Published var multiChoiceAnsers: [String] = [String]()

        @Published var animate : [Bool] = [false, false, false, false, false ]
        @Published var animationAmount: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]
        
        @Published var audioPlayer1:AVAudioPlayer?
        @Published var audioPlayer2:AVAudioPlayer?
        @Published var audioPlayer3:AVAudioPlayer?
        
        @Published var showPenalty: Bool = false
        @Published var viewID: Int = 0
        @Published var penaltyAmount = 0 
        
        var gameInfo: GameInfo = GameInfo()
        var roundInfo: RoundInfo = RoundInfo()
        var coordinator: Coordinator = Coordinator()
        var vibOn: Bool = true
        var volume: Double = 100.0
        var timerGlobal: TimerGlobal = TimerGlobal()
        
        func GetInfo(gameInfo: GameInfo, roundInfo: RoundInfo, coordinator: Coordinator, vibOn: Bool, volume: Double, timerGlobal: TimerGlobal){
            self.gameInfo = gameInfo
            self.roundInfo = roundInfo
            self.coordinator = coordinator
            self.vibOn = vibOn
            self.volume = volume
            self.timerGlobal = timerGlobal
        }
        func SetUpView(){
            if(gameInfo.multiChoice == true){
                GetOption()
            }
            if(roundInfo.roundNumber == 0 ){
                PlayBackground()
            }
        }
        func ValidateAnswer (guessIn: String) {
            showPenalty = false
            var answer: String
            answer = GetCorrectAnswer()
            
            if((guessIn.trimmingCharacters(in: .whitespaces).lowercased()
               == answer.lowercased())
               || (AlternativeName(country: answer).contains(guessIn))){
                //TODO: somehow allow like 2 - 3 charachters mispelling
                
                if(roundInfo.roundNumber == 4){
                    CorrectGuess()
                    timerGlobal.timerGlobal = Const.maxRoundScoreValue
                    coordinator.show(EndGame.self)
                }else{
                    CorrectGuess()
                    timerGlobal.timerGlobal = Const.maxRoundScoreValue
                    roundInfo.roundNumber += 1
                    coordinator.show(GameMap.self)
                }
            }
            else{
                timerGlobal.timerGlobal -= Const.PenaltyIncorrectFTB
                penaltyAmount = Const.PenaltyIncorrectFTB
                viewID += 1
                showPenalty.toggle()
                guessText = ""
                animationAmount[4] += 1
                animate[4].toggle()
                PlayIncorrect()
                PlayDefaultFeedback().play()
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
        func ValidateAnswerMultiChoice(guessIn: String, optionClicked: Int){
            showPenalty = false
            var answer: String
            answer = GetCorrectAnswer()
            
            if(guessIn == answer){

                if(roundInfo.roundNumber == 4){
                    CorrectGuess()
                    timerGlobal.timerGlobal = Const.maxRoundScoreValue
                    coordinator.show(EndGame.self)
                }else{
                    CorrectGuess()
                    timerGlobal.timerGlobal = Const.maxRoundScoreValue
                    roundInfo.roundNumber += 1
                    coordinator.show(GameMap.self)
                }
            }
            else{
                
                guessText = "" //clear text
                timerGlobal.timerGlobal -= Const.PenaltyIncorrectMC
                penaltyAmount = Const.PenaltyIncorrectMC
                showPenalty = true
                animationAmount[optionClicked] += 1
                animate[optionClicked].toggle()
                PlayIncorrect()
                PlayDefaultFeedback().play()
                viewID += 1
            }
        }
        func GetOption() {
            for i in 0...3{
                let optionIndex = Int.random(in: 0...3-i)
                
                if(gameInfo.regionMode == Const.modeRegCityText){
                    options[i] = roundInfo.multiChoiceOptions[roundInfo.roundNumber][optionIndex].city_ascii
                }else if(gameInfo.regionMode == Const.modeRegRegionText){
                    options[i] = roundInfo.multiChoiceOptions[roundInfo.roundNumber][optionIndex].admin_name
                }else{
                    options[i] = roundInfo.multiChoiceOptions[roundInfo.roundNumber][optionIndex].country
                }
                roundInfo.multiChoiceOptions[roundInfo.roundNumber].remove(at: optionIndex)
            }
        }
        func CorrectGuess(){
            if(vibOn){
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
            PlayCorrect()
            if(roundInfo.roundNumber == 4){
                audioPlayer1?.pause()
            }
            roundInfo.times[roundInfo.roundNumber] = timerGlobal.timerGlobal
            roundInfo.roundNumbers[roundInfo.roundNumber] = (roundInfo.roundNumber + 1)
            roundInfo.answers[roundInfo.roundNumber] = true
        }
        func GetCorrectAnswer()-> String{
            var answer: String
            
            if(gameInfo.regionMode == Const.modeRegCityText){
                answer = roundInfo.locations[roundInfo.roundNumber].city_ascii
            }else if(gameInfo.regionMode == Const.modeRegRegionText){
                answer = roundInfo.locations[roundInfo.roundNumber].admin_name
            }else{ //World
                answer = roundInfo.locations[roundInfo.roundNumber].country
            }
            
            return answer
        }
        func GiveUp(){
            roundInfo.answers[roundInfo.roundNumber] =  true //so the last round will show on end game, may need to change this later
            roundInfo.roundNumbers[roundInfo.roundNumber] = (roundInfo.roundNumber + 1)
            roundInfo.times[roundInfo.roundNumber] = -1 
            coordinator.show(EndGame.self)
        }
        func PlayBackground(){
            if let path = Bundle.main.path(forResource: Const.audioActionBackground, ofType: "mp3"){
                self.audioPlayer1 = AVAudioPlayer()
                //self.isPlaying.toggle()
                let url = URL(fileURLWithPath: path)
                
                do {
                    self.audioPlayer1 = try AVAudioPlayer(contentsOf: url)
                    audioPlayer1?.volume = Float(volume/100)
                    self.audioPlayer1?.prepareToPlay()
                    self.audioPlayer1?.numberOfLoops = -1
                    self.audioPlayer1?.play()
                }catch {
                    print("Error")
                }
            }
        }
        func PlayCorrect(){
            if let path = Bundle.main.path(forResource: Const.audioCorrectEffect, ofType: "mp3"){
                self.audioPlayer2 = AVAudioPlayer()
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
            if let path = Bundle.main.path(forResource: Const.audioIncorrectEffect, ofType: "mp3"){
                self.audioPlayer3 = AVAudioPlayer()
                let url = URL(fileURLWithPath: path)
                
                do {
                    self.audioPlayer3 = try AVAudioPlayer(contentsOf: url)
                    audioPlayer3?.volume = Float(volume/100)
                    self.audioPlayer3?.prepareToPlay()
                    self.audioPlayer3?.play()
                }catch {
                    print("Error")
                }
            }
        }
    }
}
