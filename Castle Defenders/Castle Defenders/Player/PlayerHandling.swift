//
//  PlayerHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//

import GameplayKit

public class PlayerHandling{
    let playerConfiguration = PlayerConfig()
    
    func CreatePlayer(gameScene: GameScene) -> PlayerNode{
        let idleFrames = self.loadPlayerIdleSFrames()
        // Create your SKSpriteNode (your archer character)
        let player = PlayerNode(texture: idleFrames[0],size: CGSize(width: playerConfiguration.playerWidth, height: playerConfiguration.playerHeight), gameScene: gameScene)
        // Animate the archer with the frames at a set speed (0.1 seconds per frame)
        player.run(SKAction.repeatForever(SKAction.animate(with: idleFrames, timePerFrame: playerConfiguration.idleSAnimationSpeed)))
        
        return player
    }
    
    func loadPlayerIdleSFrames() -> [SKTexture]{
        // Create an array to hold the animation frames
        let figureStand = UIImage(systemName: "figure.wave")!
        let figureStand2 = UIImage(systemName: "figure.arms.open")!
        let figureStand3 = UIImage(systemName: "figure")!
        let idleFrames: [SKTexture] = [SKTexture(image: figureStand),SKTexture(image: figureStand2),SKTexture(image: figureStand3)]

        return idleFrames
    }
}
