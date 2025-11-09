//
//  GameMapVM.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 3/12/23.
//

import Foundation
import CoreLocation
import UIKit

extension GameMap{
    @MainActor class GameMapVM: ObservableObject{
        
        @Published var guessText: String = ""
        
        @Published var options: [String] = ["", "", "", ""]
        @Published var multiChoiceAnsers: [String] = [String]()

        @Published var animate : [Bool] = [false, false, false, false, false ]
        @Published var animationAmount: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0]

        @Published var showPenalty: Bool = false
        @Published var viewID: Int = 0
        @Published var penaltyAmount = 0
        
        var gameInfo: GameInfo = GameInfo()
        var roundInfo: RoundInfo = RoundInfo()
        var coordinator: Coordinator = Coordinator()
        var vibOn: Bool = true
        var volume: Double = 100.0
        var timerGlobal: TimerGlobal = TimerGlobal()
        var audioPlayer: AudioPlayer = AudioPlayer()
        
        func getInfo(gameInfo: GameInfo, roundInfo: RoundInfo, coordinator: Coordinator, vibOn: Bool, volume: Double, timerGlobal: TimerGlobal, audioPlayer: AudioPlayer){
            self.gameInfo = gameInfo
            self.roundInfo = roundInfo
            self.coordinator = coordinator
            self.vibOn = vibOn
            self.volume = volume
            self.timerGlobal = timerGlobal
            self.audioPlayer = audioPlayer
        }
        func setUpView(){
            if(gameInfo.multiChoice == true){
                getOption()
            }
            if(roundInfo.roundNumber == 0 ){
                playBackground()
            }
        }
        func validateAnswer (guessIn: String) {
            showPenalty = false

//           //TODO: somehow allow like 2 - 3 charachters mispelling
            if(isCorrectGuess(guessIn: guessIn, answer: getCorrectAnswer())){

                if(roundInfo.roundNumber == 4){
                    handleCorrectGuess()
                    timerGlobal.timerGlobal = Const.maxRoundScoreValue
                    coordinator.show(EndGame.self)
                }else{
                    handleCorrectGuess()
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
                playIncorrect()
                PlayDefaultFeedback().play()
            }
        }
        func alternativeName(country: String) -> [String]{
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
            case("Congo (Brazzaville)"):
                countryNames.append("Congo")
            case("Central African Republic"):
                countryNames.append("CAR")
            case("Macedonia"):
                countryNames.append("North Macedonia")
                countryNames.append("Northern Macedonia")
                countryNames.append("FYROM")
                countryNames.append("Former Yugoslav Republic of Macedonia")
            case("Czechia"):
                countryNames.append("Czech Republic")
            case("Côte d'Ivoire"):
                countryNames.append("Ivory Coast")
                countryNames.append("Côte d'Ivoire")
                countryNames.append("Cote d Ivoire")
            case("Timor-Leste"):
                countryNames.append("East Timor")
                countryNames.append("Timor Leste")
            case("Cabo Verde"):
                countryNames.append("Cape Verde")
            case("Bosnia And Herzegovina"):
                countryNames.append("Bosnia")
            case("Turkey"):
                countryNames.append("Türkiye")
            case("Papua New Guinea"):
                countryNames.append("PNG")
            case("Federated States of Micronesia"):
                countryNames.append("Micronesia")
            case("Myanmar"):
                countryNames.append("Burma")
            
            //palestine/isreal?
            // caribean snts, taiwan?, ...
                
            default:
                break
            }
            return countryNames
        }
        func isCorrectGuess(guessIn: String, answer: String) -> Bool{
            if(guessIn.trimmingCharacters(in: .whitespaces).lowercased()
               == answer.lowercased()){
                return true
            }

            if(alternativeName(country: answer).contains(guessIn)){
                return true
            }

          return false

        }
        func validateAnswerMultiChoice(guessIn: String, optionClicked: Int){
            showPenalty = false
            var answer: String
            answer = getCorrectAnswer()

            if(guessIn == answer){

                if(roundInfo.roundNumber == 4){
                    handleCorrectGuess()
                    timerGlobal.timerGlobal = Const.maxRoundScoreValue
                    coordinator.show(EndGame.self)
                }else{
                    handleCorrectGuess()
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
                playIncorrect()
                PlayDefaultFeedback().play()
                viewID += 1
            }
        }
        func getOption() {
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
        func handleCorrectGuess(){
            if(vibOn){
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
            playCorrect()
            if(roundInfo.roundNumber == 4){
                audioPlayer.pauseBackground()
            }
            roundInfo.times[roundInfo.roundNumber] = timerGlobal.timerGlobal
            roundInfo.roundNumbers[roundInfo.roundNumber] = (roundInfo.roundNumber + 1)
            roundInfo.answers[roundInfo.roundNumber] = true
        }
        func getCorrectAnswer()-> String{
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
        func giveUp(){
            roundInfo.answers[roundInfo.roundNumber] =  true //so the last round will show on end game, may need to change this later
            roundInfo.roundNumbers[roundInfo.roundNumber] = (roundInfo.roundNumber + 1)
            roundInfo.times[roundInfo.roundNumber] = -1
            coordinator.show(EndGame.self)
        }
        func playBackground(){
            audioPlayer.playBackground(volume: volume)
        }
        func playCorrect(){
            audioPlayer.playCorrect(volume: volume)
        }
        func playIncorrect(){
            audioPlayer.playIncorrect(volume: volume)
        }
    }
}
