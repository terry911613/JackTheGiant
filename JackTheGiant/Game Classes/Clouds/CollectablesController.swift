//
//  CollectablesController.swift
//  JackTheGiant
//
//  Created by 李泰儀 on 2022/7/29.
//

import SpriteKit

class CollectablesController {
    
    func getCollectable() -> SKSpriteNode {
        
        var collectable = SKSpriteNode()
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 7)) >= 4 {
            if GameplayController.shared.life < 2 {
                collectable = SKSpriteNode(imageNamed: "Life")
                collectable.name = "Life"
                collectable.physicsBody = SKPhysicsBody(texture: collectable.texture!, size: collectable.size)
            }
        } else {
            collectable = SKSpriteNode(imageNamed: "Coin")
            collectable.name = "Coin"
            collectable.physicsBody = SKPhysicsBody(texture: collectable.texture!, size: collectable.size)
        }
        
        collectable.physicsBody?.affectedByGravity = false
        collectable.physicsBody?.categoryBitMask =  ColliderType.darkCloudAndCollectables
        collectable.physicsBody?.collisionBitMask = ColliderType.player
        collectable.zPosition = 2
        
        return collectable
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        // arc4random returns a number between 0 to (2**32)-1
        CGFloat(arc4random()) / CGFloat(UInt32.max) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
