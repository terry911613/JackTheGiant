//
//  GameManager.swift
//  JackTheGiant
//
//  Created by 李泰儀 on 2022/7/29.
//

import SpriteKit

class GameManager {
    
    static let shared = GameManager()
    
    private init() {}
    
    public var gameData = GameData()
    
    var gameStartedFromMainMenu = false
    var gameRestartedPlayerDied = false
}
