//
//  OptionScene.swift
//  JackTheGiant
//
//  Created by 李泰儀 on 2022/7/28.
//

import SpriteKit

class OptionScene: SKScene {
    
    private var easyBtn: SKSpriteNode?
    private var mediumBtn: SKSpriteNode?
    private var hardBtn: SKSpriteNode?
    
    private var sign: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        setup()
    }
    
    func setup() {
        easyBtn = childNode(withName: "EasyButton") as? SKSpriteNode
        mediumBtn = childNode(withName: "MediumButton") as? SKSpriteNode
        hardBtn = childNode(withName: "HardButton") as? SKSpriteNode
        sign = childNode(withName: "CheckSign") as? SKSpriteNode
        sign?.zPosition = 4
        setSign()
    }
    
    func setSign() {
        var node: SKSpriteNode?
        switch GameManager.shared.gameData.difficulty {
        case .easy:
            node = easyBtn
        case .medium:
            node = mediumBtn
        case .hard:
            node = hardBtn
        }
        guard let node = node else { return }
        sign?.position.y = node.position.y
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location) == easyBtn, let easyBtn = easyBtn {
                sign?.position.y = easyBtn.position.y
                GameManager.shared.gameData.difficulty = .easy
            } else if atPoint(location) == mediumBtn, let mediumBtn = mediumBtn {
                sign?.position.y = mediumBtn.position.y
                GameManager.shared.gameData.difficulty = .medium
            } else if atPoint(location) == hardBtn, let hardBtn = hardBtn {
                sign?.position.y = hardBtn.position.y
                GameManager.shared.gameData.difficulty = .hard
            } else if atPoint(location).name == "Back" {
                if let scene = MainMenuScene(fileNamed: "MainMenuScene") {
                    scene.scaleMode = .aspectFit
                    view?.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 1))
                }
            }
        }
    }
}
