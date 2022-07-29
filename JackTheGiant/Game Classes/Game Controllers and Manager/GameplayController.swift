//
//  GameplayController.swift
//  JackTheGiant
//
//  Created by 李泰儀 on 2022/7/29.
//

import SpriteKit

class GameplayController {
    
    static let shared = GameplayController()
    
    private init() {}
    
    var scoreText: SKLabelNode?
    var coinText: SKLabelNode?
    var lifeText: SKLabelNode?
    
    var score: Int = 0
    var coin: Int = 0
    var life: Int = 2
    
    func initVariables() {
        
        if GameManager.shared.gameRestartedPlayerDied {
            
            GameManager.shared.gameStartedFromMainMenu = false
            
            score = 0
            coin = 0
            life = 2
            
            scoreText?.text = "x\(score)"
            coinText?.text = "x\(coin)"
            lifeText?.text = "x\(life)"
        } else {
            
            GameManager.shared.gameRestartedPlayerDied = false
            
            scoreText?.text = "x\(score)"
            coinText?.text = "x\(coin)"
            lifeText?.text = "x\(life)"
        }
    }
}
