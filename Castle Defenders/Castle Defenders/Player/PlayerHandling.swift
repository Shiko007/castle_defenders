//
//  PlayerHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//

import GameplayKit

public class PlayerHandling{
    
    func CreatePlayer(gameScene: GameScene) -> PlayerNode{
        // Load custom castle sprite
        let castleTexture = SKTexture(imageNamed: "castle_stone")
        // Create your player node with custom sprite
        let player = PlayerNode(texture: castleTexture, size: CGSize(width: PlayerConfig.playerWidth, height: PlayerConfig.playerHeight), gameScene: gameScene)
        
        return player
    }
    
    func loadPlayerIdleSFrames() -> [SKTexture] {
        // Using static castle sprite (no animation needed for tower)
        let castleTexture = SKTexture(imageNamed: "castle_stone")
        return [castleTexture]
    }
}
