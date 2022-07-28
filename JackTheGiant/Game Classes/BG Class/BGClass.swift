//
//  BGClass.swift
//  JackTheGiant
//
//  Created by 李泰儀 on 2022/7/26.
//

import SpriteKit

class BGClass: SKSpriteNode {
    
    func moveBG(camera: SKCameraNode) {
        if position.y - size.height - 10 > camera.position.y {
            position.y -= size.height * 3
        }
    }
}
