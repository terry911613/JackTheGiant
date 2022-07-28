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
    
    var number = 0
    
    func printTheNumber() {
        print("\(number)")
    }
}
