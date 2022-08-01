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
//    public var easyScore: Int {
//        get {
//            userDef.integer(forKey: Key.easyScore.rawValue)
//        }
//        set {
//            userDef.set(newValue, forKey: Key.easyScore.rawValue)
//        }
//    }
//
//    public var mediumScore: Int {
//        get {
//            userDef.integer(forKey: Key.mediumScore.rawValue)
//        }
//        set {
//            userDef.set(newValue, forKey: Key.mediumScore.rawValue)
//        }
//    }
//
//    public var hardScore: Int {
//        get {
//            userDef.integer(forKey: Key.hardScore.rawValue)
//        }
//        set {
//            userDef.set(newValue, forKey: Key.hardScore.rawValue)
//        }
//    }
    
    public var score: Int {
        get {
            switch difficulty {
            case .easy:
                return userDef.integer(forKey: Key.easyScore.rawValue)
            case .medium:
                return userDef.integer(forKey: Key.mediumScore.rawValue)
            case .hard:
                return userDef.integer(forKey: Key.hardScore.rawValue)
            }
        }
        set {
            switch difficulty {
            case .easy:
                userDef.set(newValue, forKey: Key.easyScore.rawValue)
            case .medium:
                userDef.set(newValue, forKey: Key.mediumScore.rawValue)
            case .hard:
                userDef.set(newValue, forKey: Key.hardScore.rawValue)
            }
        }
    }
    
//    public var easyCoinScore: Int {
//        get {
//            userDef.integer(forKey: Key.easyCoinScore.rawValue)
//        }
//        set {
//            userDef.set(newValue, forKey: Key.easyCoinScore.rawValue)
//        }
//    }
//
//    public var mediumCoinScore: Int {
//        get {
//            userDef.integer(forKey: Key.mediumCoinScore.rawValue)
//        }
//        set {
//            userDef.set(newValue, forKey: Key.mediumCoinScore.rawValue)
//        }
//    }
//
//    public var hardCoinScore: Int {
//        get {
//            userDef.integer(forKey: Key.hardCoinScore.rawValue)
//        }
//        set {
//            userDef.set(newValue, forKey: Key.hardCoinScore.rawValue)
//        }
//    }
    
    public var coinScore: Int {
        get {
            switch difficulty {
            case .easy:
                return userDef.integer(forKey: Key.easyCoinScore.rawValue)
            case .medium:
                return userDef.integer(forKey: Key.mediumCoinScore.rawValue)
            case .hard:
                return userDef.integer(forKey: Key.hardCoinScore.rawValue)
            }
        }
        set {
            switch difficulty {
            case .easy:
                userDef.set(newValue, forKey: Key.easyCoinScore.rawValue)
            case .medium:
                userDef.set(newValue, forKey: Key.mediumCoinScore.rawValue)
            case .hard:
                userDef.set(newValue, forKey: Key.hardCoinScore.rawValue)
            }
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
