//
//  Player.swift
//  JakeTheGiant
//
//  Created by 李泰儀 on 2022/7/22.
//

import SpriteKit

struct ColliderType {
    static let player: UInt32 = 0
    static let cloud: UInt32 = 1
    static let darkCloudAndCollectables: UInt32 = 2
}

class Player: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    
    private var lastY = CGFloat()
    
    func initializePlayerAndAnimations() {
        
        textureAtlas = SKTextureAtlas(named: "Player.atlas")
        
        for i in 2...textureAtlas.textureNames.count {
            let name = "Goblin\(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
        
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0
        physicsBody?.categoryBitMask = ColliderType.player
        physicsBody?.collisionBitMask = ColliderType.cloud
        physicsBody?.contactTestBitMask = ColliderType.darkCloudAndCollectables
        
        lastY = position.y
    }
    
    func animatePlayer(moveLeft: Bool) {
        xScale = moveLeft ? abs(xScale) : -abs(xScale)
        run(SKAction.repeatForever(animatePlayerAction), withKey: "Animate")
    }
    
    func stopPlayerAnimation() {
        removeAction(forKey: "Animate")
        texture = SKTexture(imageNamed: "Goblin1")
        if let texureSize = texture?.size() {
            size = texureSize
        }
    }
    
    func movePlayer(moveLeft: Bool) {
        let movePosition: CGFloat = moveLeft ? -5 : 5
        position.x += movePosition
    }
    
    func setScore() {
        if position.y < lastY {
            GameplayController.shared.incrementScore()
            lastY = position.y
        }
    }
}
