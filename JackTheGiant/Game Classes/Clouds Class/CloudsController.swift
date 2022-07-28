//
//  CloudsController.swift
//  JackTheGiant
//
//  Created by 李泰儀 on 2022/7/26.
//

import SpriteKit

class CloudsController {
    
    var lastCloudPositionY = CGFloat()
    
    func shuffle(_ cloudsArray: [SKSpriteNode]) -> [SKSpriteNode] {
        
        var newCloudsArray = cloudsArray
        
        for i in stride(from: cloudsArray.count-1, to: 0, by: -1) {
            print("i = \(i)")
            let j = Int.random(in: 0...i-1)
            print("j = \(j)")
            newCloudsArray.swapAt(i, j)
        }
        
        return newCloudsArray
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        // arc4random returns a number between 0 to (2**32)-1
        CGFloat(arc4random()) / CGFloat(UInt32.max) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func createClouds() -> [SKSpriteNode] {
        
        var clouds = [SKSpriteNode]()
        
        for _ in 0..<2 {
            let cloud1 = SKSpriteNode(imageNamed: "new bed")
            cloud1.name = "1"
            let cloud2 = SKSpriteNode(imageNamed: "new bed")
            cloud2.name = "2"
            let cloud3 = SKSpriteNode(imageNamed: "new bed")
            cloud3.name = "3"
            let darkCloud = SKSpriteNode(imageNamed: "Dark Cloud")
            darkCloud.name = "Dark Cloud"
            
            cloud1.setScale(0.6)
            cloud2.setScale(0.6)
            cloud3.setScale(0.6)
            darkCloud.setScale(0.9)
            
            cloud1.physicsBody = SKPhysicsBody(texture: cloud1.texture!, size: cloud1.size)
            cloud1.physicsBody?.affectedByGravity = false
            cloud1.physicsBody?.restitution = 0
            cloud1.physicsBody?.categoryBitMask = ColliderType.cloud
            cloud1.physicsBody?.collisionBitMask = ColliderType.player
            
            cloud2.physicsBody = SKPhysicsBody(texture: cloud2.texture!, size: cloud2.size)
            cloud2.physicsBody?.affectedByGravity = false
            cloud2.physicsBody?.restitution = 0
            cloud2.physicsBody?.categoryBitMask = ColliderType.cloud
            cloud2.physicsBody?.collisionBitMask = ColliderType.player
            
            cloud3.physicsBody = SKPhysicsBody(texture: cloud3.texture!, size: cloud3.size)
            cloud3.physicsBody?.affectedByGravity = false
            cloud3.physicsBody?.restitution = 0
            cloud3.physicsBody?.categoryBitMask = ColliderType.cloud
            cloud3.physicsBody?.collisionBitMask = ColliderType.player
            
            darkCloud.physicsBody = SKPhysicsBody(texture: darkCloud.texture!, size: darkCloud.size)
            darkCloud.physicsBody?.affectedByGravity = false
            darkCloud.physicsBody?.restitution = 0
            darkCloud.physicsBody?.categoryBitMask = ColliderType.darkCloudAndCollectables
            darkCloud.physicsBody?.collisionBitMask = ColliderType.player
            
            clouds.append(cloud1)
            clouds.append(cloud2)
            clouds.append(cloud3)
            clouds.append(darkCloud)
        }
        
        clouds = shuffle(clouds)
        
        return clouds
    }
    
    func arrangeCloudsInScene(scene: SKScene,
                              distanceBetweenClouds: CGFloat,
                              center: CGFloat,
                              minX: CGFloat,
                              maxX: CGFloat,
                              initClouds: Bool) {
        
        var clouds = createClouds()
        
        if initClouds {
            while clouds[0].name == "Dark Cloud" {
                clouds = shuffle(clouds)
            }
        }
        
        var positionY = CGFloat()
        
        if initClouds {
            positionY = center - 100
        } else {
            positionY = lastCloudPositionY
        }
        
        var random = 0
        
        for i in 0..<clouds.count {
            
            var randomX = CGFloat()
            
            if random == 0 {
                randomX = randomBetweenNumbers(firstNum: center + 90, secondNum: maxX)
                random = 1
            } else if random == 1 {
                randomX = randomBetweenNumbers(firstNum: center - 90, secondNum: minX)
                random = 0
            }
            
            clouds[i].position = CGPoint(x: randomX, y: positionY)
            clouds[i].zPosition = 3
            
            scene.addChild(clouds[i])
            positionY -= distanceBetweenClouds
            lastCloudPositionY = positionY
        }
    }
}
