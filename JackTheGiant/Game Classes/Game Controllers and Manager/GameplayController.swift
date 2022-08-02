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
    var life: Int = 1
    
    func initVariables() {
        
        if GameManager.shared.gameStartedFromMainMenu {
            
            GameManager.shared.gameStartedFromMainMenu = false
            
            score = 0
            coin = 0
            life = 1
            
            scoreText?.text = "x\(score)"
            coinText?.text = "x\(coin)"
            lifeText?.text = "x\(life)"
        } else if GameManager.shared.gameRestartedPlayerDied {
            
            GameManager.shared.gameRestartedPlayerDied = false
            
            scoreText?.text = "x\(score)"
            coinText?.text = "x\(coin)"
            lifeText?.text = "x\(life)"
        }
    }
    
    func incrementScore() {
        score += 1
        scoreText?.text = "\(score)"
    }
    
    func incrementCoin() {
        coin += 1
        coinText?.text = "x\(coin)"
        
        score += 200
        scoreText?.text = "\(score)"
    }
    
    func incrementLife() {
        life += 1
        lifeText?.text = "x\(life)"
        
        score += 300
        scoreText?.text = "\(score)"
    }
}
