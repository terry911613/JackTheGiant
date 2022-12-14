//
//  GameplayScene.swift
//  JakeTheGiant
//
//  Created by 李泰儀 on 2022/7/22.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var cloudsController = CloudsController()
    var mainCamera: SKCameraNode?
    var bg1: BGClass?
    var bg2: BGClass?
    var player: Player?
    var canMove: Bool = false
    var moveLeft: Bool = false
    var center: CGFloat = .zero
    private let playerMinX: CGFloat = -200
    private let playerMaxX: CGFloat = 200
    var distanceBetweenClouds: CGFloat = 150
    let minX: CGFloat = -147
    let maxX: CGFloat = 147
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat()
    private var pausePanel: SKSpriteNode?
    private var acceleration = CGFloat()
    private var cameraSpeed = CGFloat()
    private var maxSpeed = CGFloat()
    
    override func didMove(to view: SKView) {
        initVariables()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let scene = scene else { return }
        canMove = true
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if scene.isPaused {
                if atPoint(location).name == "Resume" {
                    scene.isPaused = false
                    removePausePanel()
                } else if atPoint(location).name == "Quit" {
                    if let scene = MainMenuScene(fileNamed: "MainMenuScene") {
                        scene.scaleMode = .aspectFit
                        view?.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 1))
                    }
                }
            } else {
                if atPoint(location).name == "Pause" {
                    scene.isPaused = true
                    createPausePanel()
                    return
                }
                moveLeft = location.x < center
                player?.animatePlayer(moveLeft: moveLeft)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    func initVariables() {
        
        guard let scene = scene else { return }
        
        physicsWorld.contactDelegate = self
        
        center = scene.size.width / scene.size.height
        
        player = childNode(withName: "Player") as? Player
        player?.initializePlayerAndAnimations()
        
        mainCamera = childNode(withName: "MainCamera") as? SKCameraNode
        
        getBGs()
        getLabels()
        
        GameplayController.shared.initVariables()
        
        cloudsController.arrangeCloudsInScene(scene: scene,
                                              distanceBetweenClouds: distanceBetweenClouds,
                                              center: center,
                                              minX: minX,
                                              maxX: maxX,
                                              player: player,
                                              initClouds: true)
        
        if let mainCamera = mainCamera {
            cameraDistanceBeforeCreatingNewClouds = mainCamera.position.y - (UIScreen.main.bounds.height - 100)
        }
        
        setCameraSpeed()
        
        print("random = \(cloudsController.randomBetweenNumbers(firstNum: 2, secondNum: 5))")
    }
    
    func getBGs() {
        bg1 = childNode(withName: "BG1") as? BGClass
        bg2 = childNode(withName: "BG2") as? BGClass
//        bg3 = childNode(withName: "BG3") as? BGClass
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
        moveCamera()
        manageBGs()
        createNewClouds()
        player?.setScore()
        print("mainCamera?.position = \(mainCamera?.position)")
//        checkForChildsOutOffScreen()
    }
    
    func managePlayer() {
        guard let player = player else { return }

        if canMove {
            player.movePlayer(moveLeft: moveLeft)
        }
        
        if player.position.x > playerMaxX {
            player.position.x = playerMaxX
        } else if player.position.x < playerMinX {
            player.position.x = playerMinX
        }
        
        guard let mainCamera = mainCamera else { return }
        
        let screenHalfHeight = UIScreen.main.bounds.height / 2
        let playerHalfHeight = player.size.height / 2
        print("123 screenHalfHeight = \(screenHalfHeight)")
        print("123 playerHalfHeight = \(playerHalfHeight)")
        print("123 player.position.y = \(player.position.y)")
        print("123 mainCamera.position.y = \(mainCamera.position.y)")
        
        if player.position.y - screenHalfHeight - playerHalfHeight > mainCamera.position.y {
//            scene?.isPaused = true
            playerDiedFlow(body: nil)
            print("WTF Out bound 1")
        }
        
        if player.position.y + screenHalfHeight + playerHalfHeight < mainCamera.position.y {
//            scene?.isPaused = true
            playerDiedFlow(body: nil)
            print("WTF Out bound 2")
        }
    }
    
    func moveCamera() {
        guard let mainCamera = mainCamera else { return }
        cameraSpeed += acceleration
        if cameraSpeed > maxSpeed {
            cameraSpeed = maxSpeed
        }
        
        mainCamera.position.y -= cameraSpeed
    }
    
    func manageBGs() {
        guard let mainCamera = mainCamera else { return }
        bg1?.moveBG(camera: mainCamera)
        bg2?.moveBG(camera: mainCamera)
//        bg3?.moveBG(camera: mainCamera)
    }
    
    func createNewClouds() {
        guard let mainCamera = mainCamera, let scene = scene else { return }
        
        print("777 cameraDistanceBeforeCreatingNewClouds = \(cameraDistanceBeforeCreatingNewClouds)")
        print("777 mainCamera.position.y = \(mainCamera.position.y)")
        if cameraDistanceBeforeCreatingNewClouds > mainCamera.position.y {
            
            print("777 UIScreen.main.bounds.height = \(UIScreen.main.bounds.height)")
            cameraDistanceBeforeCreatingNewClouds = mainCamera.position.y - (UIScreen.main.bounds.height - 100)
            
            cloudsController.arrangeCloudsInScene(scene: scene,
                                                  distanceBetweenClouds: distanceBetweenClouds,
                                                  center: center,
                                                  minX: minX,
                                                  maxX: maxX,
                                                  player: player,
                                                  initClouds: false)
//            checkForChildsOutOffScreen()
        }
        checkForChildsOutOffScreen()
    }
    
    func checkForChildsOutOffScreen() {
        guard let scene = scene, let mainCamera = mainCamera else { return }
        print("777 scene.size.height = \(scene.size.height)")
        for child in children {
            if child.position.y > mainCamera.position.y + (scene.size.height / 2) + (child.frame.size.height / 2) {
//                print("child.name = \(child.name)")
                if let name = child.name, !name.contains("BG"), !name.contains("Player") {
                    child.removeFromParent()
                    print("name: \(name) is remove")
                }
            }
        }
    }
    
    func getLabels() {
        GameplayController.shared.scoreText = mainCamera?.childNode(withName: "ScoreText") as? SKLabelNode
        GameplayController.shared.coinText = mainCamera?.childNode(withName: "CoinText") as? SKLabelNode
        GameplayController.shared.lifeText = mainCamera?.childNode(withName: "LifeText") as? SKLabelNode
    }
    
    func createPausePanel() {
        
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu")
        let resumeButton = SKSpriteNode(imageNamed: "Resume Button")
        let quitButton = SKSpriteNode(imageNamed: "Quit Button 2")
        
        pausePanel?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pausePanel?.setScale(1.6)
        pausePanel?.zPosition = 5
        
        if let mainCamera = mainCamera {
            pausePanel?.position = CGPoint(x: mainCamera.frame.width / 2, y: mainCamera.frame.height / 2)
        }
        
        guard let pausePanel = pausePanel else { return }
        
        resumeButton.name = "Resume"
        resumeButton.zPosition = 6
        resumeButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        resumeButton.position = CGPoint(x: pausePanel.position.x, y: pausePanel.position.y + 25)
        
        quitButton.name = "Quit"
        quitButton.zPosition = 6
        quitButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        quitButton.position = CGPoint(x: pausePanel.position.x, y: pausePanel.position.y - 45)
        
        pausePanel.addChild(resumeButton)
        pausePanel.addChild(quitButton)
        
        mainCamera?.addChild(pausePanel)
    }
    
    func createEndScroePanel() {
        let endScorePanel = SKSpriteNode(imageNamed: "Show Score")
        let scoreLabel = SKLabelNode(fontNamed: "Blow")
        let coinLabel = SKLabelNode(fontNamed: "Blow")
        
        endScorePanel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        endScorePanel.zPosition = 8
        endScorePanel.xScale = 1.5
        endScorePanel.yScale = 1.5
        
        scoreLabel.fontSize = 50
        scoreLabel.zPosition = 7
        
        coinLabel.fontSize = 50
        coinLabel.zPosition = 7
        
        scoreLabel.text = "\(GameplayController.shared.score)"
        coinLabel.text = "\(GameplayController.shared.coin)"
        
        endScorePanel.addChild(scoreLabel)
        endScorePanel.addChild(coinLabel)
        
        guard let mainCamera = mainCamera else { return }

        endScorePanel.position = CGPoint(x: mainCamera.frame.width / 2, y: mainCamera.frame.height / 2)
        
        scoreLabel.position = CGPoint(x: endScorePanel.position.x - 60, y: endScorePanel.position.y + 10)
        coinLabel.position = CGPoint(x: endScorePanel.position.x - 60, y: endScorePanel.position.y - 105)
        
        mainCamera.addChild(endScorePanel)
    }
    
    func removePausePanel() {
        pausePanel?.removeFromParent()
    }
    
    func setCameraSpeed() {
        let data = GameManager.shared.gameData
        switch data.difficulty {
        case .easy:
            acceleration = 0.001
            cameraSpeed = 1.5
            maxSpeed = 4
        case .medium:
            acceleration = 0.002
            cameraSpeed = 2
            maxSpeed = 6
        case .hard:
            acceleration = 0.003
            cameraSpeed = 2.5
            maxSpeed = 8
        }
    }
    
    private func playerDied() {
        let data = GameManager.shared.gameData
        if GameplayController.shared.life >= 0 {
            
            GameManager.shared.gameRestartedPlayerDied = true
            
            if let scene = GameplayScene(fileNamed: "GameplayScene") {
                scene.scaleMode = .aspectFit
                view?.presentScene(scene, transition: .doorsOpenVertical(withDuration: 1))
            }
        } else {
            if data.score < GameplayController.shared.score {
                data.score = GameplayController.shared.score
            }
            if data.coinScore < GameplayController.shared.coin {
                data.coinScore = GameplayController.shared.coin
            }
            
            if let scene = MainMenuScene(fileNamed: "MainMenuScene") {
                scene.scaleMode = .aspectFit
                view?.presentScene(scene, transition: .doorsOpenHorizontal(withDuration: 1))
            }
        }
    }
    
    private func playerDiedFlow(body: SKPhysicsBody?) {
        scene?.isPaused = true
        GameplayController.shared.life -= 1
        print("WTF GameplayController.shared.life = \(GameplayController.shared.life)")
        if GameplayController.shared.life >= 0 {
            GameplayController.shared.lifeText?.text = "x\(GameplayController.shared.life)"
        } else {
            createEndScroePanel()
        }
        body?.node?.removeFromParent()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.playerDied()
        }
    }
}

extension GameplayScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" {
            
            if secondBody.node?.name == "Life" {
                
                run(SKAction.playSoundFileNamed("Life Sound.wav", waitForCompletion: false))
                
                GameplayController.shared.incrementLife()
                
                secondBody.node?.removeFromParent()
                
            } else if secondBody.node?.name == "Coin" {
                
                run(SKAction.playSoundFileNamed("Coin Sound.wav", waitForCompletion: false))
                
                GameplayController.shared.incrementCoin()
                
                secondBody.node?.removeFromParent()
                
            } else if secondBody.node?.name == "DarkCloud" {
                print("WTF DarkCloud")
                playerDiedFlow(body: firstBody)
            }
        }
    }
}
