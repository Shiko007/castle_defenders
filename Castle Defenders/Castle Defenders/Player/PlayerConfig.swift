//
//  PlayerConfig.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//
import SpriteKit

struct PlayerConfig {
    static let idleSAnimationSpeed = 0.15
    static let playerWidth : CGFloat = 50
    static let playerHeight : CGFloat = 50
    static let playerLevelExperience : Int = 100
    static let playerLevelExpIncrement : Int = 10
    
    //Attack Config
    static let attackDamage : Int = 10
    static let attackCD : TimeInterval = 0.5
    static let attackProjectileSpeed : CGFloat = 0.2
    static let attackRange : CGFloat = 300
    static let attackCount : Int = 300
    static let attackThreashold : CGFloat = 30
    
    //Range Config
    static let playerRangeColorAlpha : CGFloat = 0.05
    static let playerRangeColor : UIColor = .lightGray
    static let playerRangeLineW : CGFloat = 1
    
    //Exp Config
    static let expBarLineWidth : CGFloat = 5
    static let expBarLineColor : UIColor = .brown
    static let expBarAlpha : CGFloat = 0.9
    
    //Drops Config
    static let goldChanceFactor : Int = 0
    
    //Auto Features
    static let autoCollectGold : Bool = true
    
    //HUD Features
    static let showCollectedGold : Bool = true
    static let showAttackDamage : Bool = true
}
