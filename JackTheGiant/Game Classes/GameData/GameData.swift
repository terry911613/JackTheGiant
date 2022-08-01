//
//  GameData.swift
//  JackTheGiant
//
//  Created by 李泰儀 on 2022/8/1.
//

import Foundation

class GameData {
    
    private let userDef = UserDefaults.standard
    
    // MARK: - Keys
    private enum Key: String, CaseIterable {
        case easyScore
        case mediumScore
        case hardScore
        case easyCoinScore
        case mediumCoinScore
        case hardCoinScore
        case difficulty
        case isMusicOn
    }
    
    // MARK: - Value
    public var easyScore: Int {
        get {
            userDef.integer(forKey: Key.easyScore.rawValue)
        }
        set {
            userDef.set(newValue, forKey: Key.easyScore.rawValue)
        }
    }
    
    public var mediumScore: Int {
        get {
            userDef.integer(forKey: Key.mediumScore.rawValue)
        }
        set {
            userDef.set(newValue, forKey: Key.mediumScore.rawValue)
        }
    }
    
    public var hardScore: Int {
        get {
            userDef.integer(forKey: Key.hardScore.rawValue)
        }
        set {
            userDef.set(newValue, forKey: Key.hardScore.rawValue)
        }
    }
    
    public var score: Int {
        switch difficulty {
        case .easy:
            return easyScore
        case .medium:
            return mediumScore
        case .hard:
            return hardScore
        }
    }
    
    public var easyCoinScore: Int {
        get {
            userDef.integer(forKey: Key.easyCoinScore.rawValue)
        }
        set {
            userDef.set(newValue, forKey: Key.easyCoinScore.rawValue)
        }
    }
    
    public var mediumCoinScore: Int {
        get {
            userDef.integer(forKey: Key.mediumCoinScore.rawValue)
        }
        set {
            userDef.set(newValue, forKey: Key.mediumCoinScore.rawValue)
        }
    }
    
    public var hardCoinScore: Int {
        get {
            userDef.integer(forKey: Key.hardCoinScore.rawValue)
        }
        set {
            userDef.set(newValue, forKey: Key.hardCoinScore.rawValue)
        }
    }
    
    public var coinScore: Int {
        switch difficulty {
        case .easy:
            return easyCoinScore
        case .medium:
            return mediumCoinScore
        case .hard:
            return hardCoinScore
        }
    }
    
    public var difficulty: Difficulty {
        get {
            let value = userDef.integer(forKey: Key.difficulty.rawValue)
            if let difficulty = Difficulty(rawValue: value) {
                return difficulty
            }
            return .easy
        }
        set {
            userDef.set(newValue.rawValue, forKey: Key.difficulty.rawValue)
        }
    }
    
    public var isMusicOn: Bool {
        get {
            userDef.bool(forKey: Key.isMusicOn.rawValue)
        }
        set {
            userDef.set(newValue, forKey: Key.isMusicOn.rawValue)
        }
    }
}
