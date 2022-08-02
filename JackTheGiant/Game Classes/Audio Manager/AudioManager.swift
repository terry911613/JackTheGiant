//
//  AudioManager.swift
//  JackTheGiant
//
//  Created by 李泰儀 on 2022/8/2.
//

import SpriteKit
import AVFoundation

class AudioManager {
    
    static let shared = AudioManager()
    
    var isPlayingBG = true
    let backgroundMusic = SKAudioNode(fileNamed: "Background music.mp3")
    let clickMusic = SKAudioNode(fileNamed: "Click Sound.mp3")
    let coinMusic = SKAudioNode(fileNamed: "Coin Sound.mp3")
    let lifeMusic = SKAudioNode(fileNamed: "Life Sound.mp3")
    
    private var audioPlayer: AVAudioPlayer?
    
    private init() {
        backgroundMusic.autoplayLooped = true
    }
    
    func setBGMusic(_ play: Bool, scene: SKScene?) {
        isPlayingBG = play
        if isPlayingBG {
            playBGMusic(scene: scene)
        } else {
            stopBGMusic()
        }
    }
    
    func playBGMusic(scene: SKScene?) {
        // solution 1 (only in particular scene)
//        backgroundMusic.autoplayLooped = true
//        scene?.addChild(backgroundMusic)
        
        // solution 2
        guard let url = Bundle.main.url(forResource: "Background music", withExtension: "mp3") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("error = \(error)")
        }
    }
    
    func stopBGMusic() {
        // solution 1
//        backgroundMusic.removeFromParent()
        
        // solution 2
        guard let audioPlayer = audioPlayer else { return }

        if audioPlayer.isPlaying {
            audioPlayer.stop()
        }
    }
    
    func isSetupAudioPlayer() -> Bool {
        audioPlayer == nil
    }
}
