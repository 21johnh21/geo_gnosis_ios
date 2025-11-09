//
//  AudioPlayer.swift
//  geo_gnosis_ios
//
//  Created by John Hawley on 4/4/23.
//

import Foundation
import AVFAudio
import os.log

class AudioPlayer: ObservableObject{

    @Published var backgroundAudio = AVAudioPlayer()
    private var correctEffectPlayer: AVAudioPlayer?
    private var incorrectEffectPlayer: AVAudioPlayer?
    var volume: Double = 0

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "geo_gnosis_ios", category: "AudioPlayer")

    init() {
        // Pre-load sound effects to avoid creating players on each play
        setupSoundEffects()
    }

    private func setupSoundEffects() {
        // Setup correct sound effect player
        loadAudioEffect(
            resource: Const.audioCorrectEffect,
            into: &correctEffectPlayer,
            effectName: "correct"
        )

        // Setup incorrect sound effect player
        loadAudioEffect(
            resource: Const.audioIncorrectEffect,
            into: &incorrectEffectPlayer,
            effectName: "incorrect"
        )
    }

    private func loadAudioEffect(resource: String, into player: inout AVAudioPlayer?, effectName: String) {
        guard let path = Bundle.main.path(forResource: resource, withExtension: "mp3") else {
            logger.error("Audio file not found: \(resource).mp3")
            return
        }

        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            logger.info("Successfully loaded \(effectName) sound effect")
        } catch {
            logger.error("Failed to load \(effectName) sound effect: \(error.localizedDescription)")
        }
    }

    func playBackground(volume: Double){
        guard let path = Bundle.main.path(forResource: Const.audioActionBackground, withExtension: "mp3") else {
            logger.error("Background audio file not found: \(Const.audioActionBackground).mp3")
            return
        }

        let url = URL(fileURLWithPath: path)
        do {
            backgroundAudio = try AVAudioPlayer(contentsOf: url)
            backgroundAudio.volume = Float(volume/100)
            backgroundAudio.prepareToPlay()
            backgroundAudio.numberOfLoops = -1
            backgroundAudio.play()
            logger.info("Background audio started successfully")
        } catch {
            logger.error("Failed to play background audio: \(error.localizedDescription)")
        }
    }

    func stopBackground(){
        backgroundAudio.stop()
    }

    func pauseBackground(){
        backgroundAudio.pause()
    }

    func playCorrect(volume: Double) {
        guard let player = correctEffectPlayer else {
            logger.warning("Correct effect player not available")
            return
        }
        player.volume = Float(volume/100)
        player.currentTime = 0  // Restart from beginning
        player.play()
    }

    func playIncorrect(volume: Double) {
        guard let player = incorrectEffectPlayer else {
            logger.warning("Incorrect effect player not available")
            return
        }
        player.volume = Float(volume/100)
        player.currentTime = 0  // Restart from beginning
        player.play()
    }

    func setVolume(volume: Double){
        self.volume = volume
    }
}
