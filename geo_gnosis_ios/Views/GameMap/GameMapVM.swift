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
        @Published var showSuccess: Bool = false
        @Published var showError: Bool = false
        
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
            // Light haptic feedback for submission
            if(vibOn){
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
            }

            showPenalty = false

            if(isCorrectGuess(guessIn: guessIn, answer: getCorrectAnswer())){
                showSuccess = true

                Task {
                    try? await Task.sleep(nanoseconds: 800_000_000) // 0.8 seconds

                    if(roundInfo.roundNumber == 4){
                        handleCorrectGuess()
                        timerGlobal.timerGlobal = Const.maxRoundScoreValue
                        showSuccess = false
                        coordinator.show(EndGame.self)
                    }else{
                        handleCorrectGuess()
                        timerGlobal.timerGlobal = Const.maxRoundScoreValue
                        showSuccess = false
                        roundInfo.roundNumber += 1
                        coordinator.show(GameMap.self)
                    }
                }
            }
            else{
                showError = true
                timerGlobal.timerGlobal -= Const.PenaltyIncorrectFTB
                penaltyAmount = Const.PenaltyIncorrectFTB
                viewID += 1
                showPenalty.toggle()
                guessText = ""
                animationAmount[4] += 1
                animate[4].toggle()
                playIncorrect()

                // Error haptic feedback
                if(vibOn){
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                }

                Task {
                    try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
                    showError = false
                }
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
        func levenshteinDistance(_ s1: String, _ s2: String) -> Int {
            let s1 = Array(s1.lowercased())
            let s2 = Array(s2.lowercased())

            var matrix = [[Int]](repeating: [Int](repeating: 0, count: s2.count + 1), count: s1.count + 1)

            for i in 0...s1.count {
                matrix[i][0] = i
            }
            for j in 0...s2.count {
                matrix[0][j] = j
            }

            for i in 1...s1.count {
                for j in 1...s2.count {
                    let cost = s1[i - 1] == s2[j - 1] ? 0 : 1
                    matrix[i][j] = min(
                        matrix[i - 1][j] + 1,      // deletion
                        matrix[i][j - 1] + 1,      // insertion
                        matrix[i - 1][j - 1] + cost // substitution
                    )
                }
            }

            return matrix[s1.count][s2.count]
        }

        func isCorrectGuess(guessIn: String, answer: String) -> Bool{
            let cleanGuess = guessIn.trimmingCharacters(in: .whitespaces).lowercased()
            let cleanAnswer = answer.lowercased()

            // Exact match
            if cleanGuess == cleanAnswer {
                return true
            }

            // Check alternative names
            if alternativeName(country: answer).contains(where: { $0.lowercased() == cleanGuess }) {
                return true
            }

            // Fuzzy match: Allow up to 3 character mistakes
            // But require at least 4 characters to prevent too lenient matching on short words
            if cleanGuess.count >= 4 {
                let distance = levenshteinDistance(cleanGuess, cleanAnswer)
                let threshold = min(3, cleanAnswer.count / 4) // Max 3 errors, or 25% of word length

                if distance <= threshold {
                    return true
                }

                // Also check fuzzy matching against alternative names
                for altName in alternativeName(country: answer) {
                    let altDistance = levenshteinDistance(cleanGuess, altName.lowercased())
                    if altDistance <= threshold {
                        return true
                    }
                }
            }

            return false
        }
        func validateAnswerMultiChoice(guessIn: String, optionClicked: Int){
            // Light haptic feedback for button tap
            if(vibOn){
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
            }

            showPenalty = false
            var answer: String
            answer = getCorrectAnswer()

            if(guessIn == answer){
                showSuccess = true

                Task {
                    try? await Task.sleep(nanoseconds: 800_000_000) // 0.8 seconds

                    if(roundInfo.roundNumber == 4){
                        handleCorrectGuess()
                        timerGlobal.timerGlobal = Const.maxRoundScoreValue
                        showSuccess = false
                        coordinator.show(EndGame.self)
                    }else{
                        handleCorrectGuess()
                        timerGlobal.timerGlobal = Const.maxRoundScoreValue
                        showSuccess = false
                        roundInfo.roundNumber += 1
                        coordinator.show(GameMap.self)
                    }
                }
            }
            else{
                showError = true
                guessText = "" //clear text
                timerGlobal.timerGlobal -= Const.PenaltyIncorrectMC
                penaltyAmount = Const.PenaltyIncorrectMC
                showPenalty = true
                animationAmount[optionClicked] += 1
                animate[optionClicked].toggle()
                playIncorrect()

                // Error haptic feedback
                if(vibOn){
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                }

                viewID += 1

                Task {
                    try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
                    showError = false
                }
            }
        }
        func getOption() {
            // Guard against invalid round number or empty options
            guard roundInfo.roundNumber < roundInfo.multiChoiceOptions.count,
                  !roundInfo.multiChoiceOptions[roundInfo.roundNumber].isEmpty else {
                print("Error: Invalid round number or empty multiple choice options")
                return
            }

            for i in 0...3{
                let currentOptions = roundInfo.multiChoiceOptions[roundInfo.roundNumber]
                guard !currentOptions.isEmpty else {
                    print("Error: No more options available for round \(roundInfo.roundNumber)")
                    break
                }

                let optionIndex = Int.random(in: 0...currentOptions.count-1)

                if(gameInfo.regionMode == Const.modeRegCityText){
                    options[i] = currentOptions[optionIndex].city_ascii
                }else if(gameInfo.regionMode == Const.modeRegRegionText){
                    options[i] = currentOptions[optionIndex].admin_name
                }else{
                    options[i] = currentOptions[optionIndex].country
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
            // Guard against invalid round number
            guard roundInfo.roundNumber < roundInfo.locations.count else {
                print("Error: Invalid round number \(roundInfo.roundNumber), only have \(roundInfo.locations.count) locations")
                return ""
            }

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
        func skipRound(){
            // Medium haptic feedback for skip action
            if(vibOn){
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            }

            // Record skip with 0 points
            roundInfo.answers[roundInfo.roundNumber] = false // Incorrect answer
            roundInfo.roundNumbers[roundInfo.roundNumber] = (roundInfo.roundNumber + 1)
            roundInfo.times[roundInfo.roundNumber] = 0 // 0 points for skipped round

            // Check if this is the last round
            if(roundInfo.roundNumber == 4){
                timerGlobal.timerGlobal = Const.maxRoundScoreValue
                audioPlayer.pauseBackground()
                coordinator.show(EndGame.self)
            } else {
                // Move to next round
                timerGlobal.timerGlobal = Const.maxRoundScoreValue
                roundInfo.roundNumber += 1
                coordinator.show(GameMap.self)
            }
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
