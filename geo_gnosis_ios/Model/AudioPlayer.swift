//
//  AudioPlayer.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 4/4/23.
//

import Foundation
import AVFAudio

class AudioPlayer: ObservableObject{

    @Published var backgroundAudio = AVAudioPlayer()
    private var correctEffectPlayer: AVAudioPlayer?
    private var incorrectEffectPlayer: AVAudioPlayer?
    var volume: Double = 0

    init() {
        // Pre-load sound effects to avoid creating players on each play
        setupSoundEffects()
    }

    private func setupSoundEffects() {
        // Setup correct sound effect player
        if let path = Bundle.main.path(forResource: Const.audioCorrectEffect, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                correctEffectPlayer = try AVAudioPlayer(contentsOf: url)
                correctEffectPlayer?.prepareToPlay()
            } catch {
                print("Error loading correct sound effect: \(error.localizedDescription)")
            }
        }

        // Setup incorrect sound effect player
        if let path = Bundle.main.path(forResource: Const.audioIncorrectEffect, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                incorrectEffectPlayer = try AVAudioPlayer(contentsOf: url)
                incorrectEffectPlayer?.prepareToPlay()
            } catch {
                print("Error loading incorrect sound effect: \(error.localizedDescription)")
            }
        }
    }

    func PlayBackground(volume: Double){
        if let path = Bundle.main.path(forResource: Const.audioActionBackground, ofType: "mp3"){
            backgroundAudio = AVAudioPlayer()
            let url = URL(fileURLWithPath: path)

            do {
                backgroundAudio = try AVAudioPlayer(contentsOf: url)
                backgroundAudio.volume = Float(volume/100)
                backgroundAudio.prepareToPlay()
                backgroundAudio.numberOfLoops = -1
                backgroundAudio.play()
            }catch {
                print("Error loading background audio: \(error.localizedDescription)")
            }
        }
    }

    func StopBackground(){
        backgroundAudio.stop()
    }

    func PauseBackground(){
        backgroundAudio.pause()
    }

    func PlayCorrect(volume: Double) {
        correctEffectPlayer?.volume = Float(volume/100)
        correctEffectPlayer?.currentTime = 0  // Restart from beginning
        correctEffectPlayer?.play()
    }

    func PlayIncorrect(volume: Double) {
        incorrectEffectPlayer?.volume = Float(volume/100)
        incorrectEffectPlayer?.currentTime = 0  // Restart from beginning
        incorrectEffectPlayer?.play()
    }

    func SetVolume(volume: Double){
        self.volume = volume
    }
}
