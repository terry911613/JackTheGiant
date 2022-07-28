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
    var bg3: BGClass?
    var player: Player?
    var canMove: Bool = false
    var moveLeft: Bool = false
    var center: CGFloat = .zero
    var distanceBetweenClouds: CGFloat = 240
    let minX: CGFloat = -160
    let maxX: CGFloat = 160
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat()
    private var pausePanel: SKSpriteNode?
    
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    func initVariables() {
        
        guard let scene = scene else { return }
        
        center = scene.size.width / scene.size.height
        
        player = childNode(withName: "Player") as? Player
        player?.initializePlayerAndAnimations()
        
        mainCamera = childNode(withName: "MainCamera") as? SKCameraNode
        
        getBGs()
        cloudsController.arrangeCloudsInScene(scene: scene,
                                              distanceBetweenClouds: distanceBetweenClouds,
                                              center: center,
                                              minX: minX,
                                              maxX: maxX,
                                              initClouds: true)
        
        if let mainCamera = mainCamera {
            cameraDistanceBeforeCreatingNewClouds = mainCamera.position.y - 400
        }
        
        print("random = \(cloudsController.randomBetweenNumbers(firstNum: 2, secondNum: 5))")
    }
    
    func getBGs() {
        bg1 = childNode(withName: "BG1") as? BGClass
        bg2 = childNode(withName: "BG2") as? BGClass
        bg3 = childNode(withName: "BG3") as? BGClass
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
        moveCamera()
        manageBGs()
        createNewClouds()
    }
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
    }
    
    func moveCamera() {
        guard let mainCamera = mainCamera else { return }
        mainCamera.position.y -= 3
    }
    
    func manageBGs() {
        guard let mainCamera = mainCamera else { return }
        bg1?.moveBG(camera: mainCamera)
        bg2?.moveBG(camera: mainCamera)
        bg3?.moveBG(camera: mainCamera)
    }
    
    func createNewClouds() {
        guard let mainCamera = mainCamera, let scene = scene else { return }

        if cameraDistanceBeforeCreatingNewClouds > mainCamera.position.y {
            
            cameraDistanceBeforeCreatingNewClouds = mainCamera.position.y - 400
            
            cloudsController.arrangeCloudsInScene(scene: scene,
                                                  distanceBetweenClouds: distanceBetweenClouds,
                                                  center: center,
                                                  minX: minX,
                                                  maxX: maxX,
                                                  initClouds: false)
        }
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
    
    func removePausePanel() {
        pausePanel?.removeFromParent()
    }
}
