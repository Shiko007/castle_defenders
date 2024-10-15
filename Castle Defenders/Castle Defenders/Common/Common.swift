//
//  Common.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//

import SpriteKit

public class Common {
    let gameSceneBGColor: UIColor = .white
    
    func viewToSceneMapping(point: CGPoint, view: SKView, scene: SKScene) -> CGPoint{
        let xMap = ((point.x - view.bounds.minX) * (scene.bounds.maxX - scene.bounds.minX)) / (view.bounds.minX - view.bounds.maxX) + scene.bounds.minX
        let yMap = ((point.y - view.bounds.minY) * (scene.bounds.maxY - scene.bounds.minY)) / (view.bounds.minY - view.bounds.maxY) + scene.bounds.minY
        return CGPoint(x: xMap, y: yMap)
    }
}

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let monster: UInt32 = 0b1  // 1
    static let player: UInt32 = 0b10 // 2
}
