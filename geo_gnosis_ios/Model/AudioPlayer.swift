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
    var volume: Double = 0
    
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
                print("Error")
            }
        }
    }
    func StopBackground(){
        backgroundAudio.stop()
    }
    func SetVolume(volume: Double){
        self.volume = volume
    }
}
