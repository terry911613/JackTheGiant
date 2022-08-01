//
//  AppCore.swift
//  JackTheGiant
//
//  Created by 李泰儀 on 2022/8/1.
//

import Foundation

class AppCore {
    
    public static let shared = AppCore()
    
    private let config = AppInfoConfig()
    
    init() {
    }
    
    // MARK: - convenience variables
    public class var config: AppInfoConfig {
        shared.config
    }
}
