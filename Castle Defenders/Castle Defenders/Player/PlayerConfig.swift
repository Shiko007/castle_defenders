//
//  PlayerConfig.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//
import SpriteKit

public class PlayerConfig {
    let idleSAnimationSpeed = 0.15
    let playerWidth : CGFloat = 50
    let playerHeight : CGFloat = 50
    let playerLevelExperience : Int = 100
    let playerLevelExpIncrement : Int = 10
    
    //Attack Config
    let attackDamage : Int = 10
    let attackCD : TimeInterval = 0.3
    let attackProjectileSpeed : CGFloat = 0.5
    let attackRange : CGFloat = 300
    let attackCount : Int = 300
    let attackThreashold : CGFloat = 30
    
    //Range Config
    let playerRangeColorAlpha : CGFloat = 0.05
    let playerRangeColor : UIColor = .lightGray
    let playerRangeLineW : CGFloat = 1
    
    //Exp Config
    let expBarLineWidth : CGFloat = 5
    let expBarLineColor : UIColor = .yellow
    let expBarAlpha : CGFloat = 0.5
}
