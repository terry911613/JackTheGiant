//
//  MainMenuScene.swift
//  JackTheGiant
//
//  Created by 李泰儀 on 2022/7/28.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    var highScoreButton: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        highScoreButton = childNode(withName: "HighScore") as? SKSpriteNode
        
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
            }
        }
    }
}
