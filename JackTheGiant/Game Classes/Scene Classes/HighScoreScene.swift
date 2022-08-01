//
//  HighScoreScene.swift
//  JackTheGiant
//
//  Created by 李泰儀 on 2022/7/28.
//

import SpriteKit

class HighScoreScene: SKScene {
    
    private var scoreLabel: SKLabelNode?
    private var coinLabel: SKLabelNode?
    
    override func didMove(to view: SKView) {
        
    }
    
    private func setup() {
        scoreLabel = childNode(withName: "ScoreLabel") as? SKLabelNode
        coinLabel = childNode(withName: "CoinLabel") as? SKLabelNode
    }
    
    private func setScore() {
        let data = GameManager.shared.gameData
        scoreLabel?.text = "\(data.score)"
        coinLabel?.text = "\(data.coinScore)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Back" {
                if let scene = MainMenuScene(fileNamed: "MainMenuScene") {
                    scene.scaleMode = .aspectFit
                    view?.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 1))
                }
            }
        }
    }
}
