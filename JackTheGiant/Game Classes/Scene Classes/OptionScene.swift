//
//  OptionScene.swift
//  JackTheGiant
//
//  Created by 李泰儀 on 2022/7/28.
//

import SpriteKit

class OptionScene: SKScene {
    
    override func didMove(to view: SKView) {
        
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
