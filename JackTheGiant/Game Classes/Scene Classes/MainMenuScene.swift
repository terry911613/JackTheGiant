//
//  MainMenuScene.swift
//  JackTheGiant
//
//  Created by 李泰儀 on 2022/7/28.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    var highScoreButton: SKSpriteNode?
    var musicButton: SKSpriteNode?
    var musicOnTexture = SKTexture(imageNamed: "Music On Button")
    var musicOffTexture = SKTexture(imageNamed: "Music Off Button")
    
    override func didMove(to view: SKView) {
        highScoreButton = childNode(withName: "HighScore") as? SKSpriteNode
        musicButton = childNode(withName: "Music") as? SKSpriteNode
        setMusic()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
//            atPoint(location).name == "HighScore"
            if atPoint(location).name == "StartGame" {
                if let scene = GameplayScene(fileNamed: "GameplayScene") {
                    GameManager.shared.gameStartedFromMainMenu = true
                    scene.scaleMode = .aspectFit
                    view?.presentScene(scene, transition: .doorsOpenVertical(withDuration: 1))
                }
            } else if atPoint(location) == highScoreButton {
                if let scene = HighScoreScene(fileNamed: "HighScoreScene") {
                    scene.scaleMode = .aspectFit
                    view?.presentScene(scene, transition: .doorsOpenVertical(withDuration: 1))
                }
            } else if atPoint(location).name == "Option" {
                if let scene = OptionScene(fileNamed: "OptionScene") {
                    scene.scaleMode = .aspectFit
                    view?.presentScene(scene, transition: .doorsOpenVertical(withDuration: 1))
                }
            } else if atPoint(location) == musicButton {
                handleMusicButton()
            }
        }
    }
    
    private func setMusic() {
        if GameManager.shared.gameData.isMusicOn {
            if AudioManager.shared.isSetupAudioPlayer() {
                AudioManager.shared.setBGMusic(true, scene: scene)
                musicButton?.normalTexture = musicOffTexture
                musicButton?.texture = musicOffTexture
            }
        } else {
            musicButton?.normalTexture = musicOnTexture
            musicButton?.texture = musicOnTexture
        }
    }
    
    private func handleMusicButton() {
        let data = GameManager.shared.gameData
        if data.isMusicOn {
            AudioManager.shared.setBGMusic(false, scene: scene)
            data.isMusicOn = false
            musicButton?.normalTexture = musicOnTexture
            musicButton?.texture = musicOnTexture
        } else {
            AudioManager.shared.setBGMusic(true, scene: scene)
            data.isMusicOn = true
            musicButton?.normalTexture = musicOffTexture
            musicButton?.texture = musicOffTexture
        }
    }
}
