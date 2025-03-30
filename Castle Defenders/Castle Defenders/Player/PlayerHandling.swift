//
//  PlayerHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//

import GameplayKit

public class PlayerHandling{
    
    func CreatePlayer(gameScene: GameScene) -> PlayerNode{
        let idleFrames = self.loadPlayerIdleSFrames()
        // Create your SKSpriteNode (your archer character)
        let player = PlayerNode(texture: idleFrames[0],size: CGSize(width: PlayerConfig.playerWidth, height: PlayerConfig.playerHeight), gameScene: gameScene)
        // Animate the archer with the frames at a set speed (0.1 seconds per frame)
        player.run(SKAction.repeatForever(SKAction.animate(with: idleFrames, timePerFrame: PlayerConfig.idleSAnimationSpeed)))
        
        return player
    }
    
    func loadPlayerIdleSFrames() -> [SKTexture] {
        var idleFrames: [SKTexture] = []
        for i in 1...9 {
            let texture = SKTexture(imageNamed: "archer_idle_\(i)")
            idleFrames.append(texture)
        }
        return idleFrames
    }
}
