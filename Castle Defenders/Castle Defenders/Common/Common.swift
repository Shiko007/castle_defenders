//
//  Common.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//

import SpriteKit

public class Common {
    let gameSceneBGColor: UIColor = .white
}

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let monster: UInt32 = 0b1  // 1
    static let attack: UInt32 = 0b10   // 2
    static let player: UInt32 = 0b100 // 4
}
