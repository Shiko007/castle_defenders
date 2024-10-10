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
    
    //Attack Config
    let attackCD : TimeInterval = 0.2
    
    //Range Config
    let attackRange : CGFloat = 200
    let playerRangeColorAlpha : CGFloat = 0.05
    let playerRangeColor : UIColor = .lightGray
    let playerRangeLineW : CGFloat = 1
    //let idleSPlayerAsset = "valla_idle_s_"
}
