//
//  PlayerHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//

import GameplayKit

public class PlayerHandling{
    func CreatePlayer() -> SKSpriteNode{
        let idleFrames = self.loadPlayerIdleSFrames()
        // Create your SKSpriteNode (your archer character)
        let player = SKSpriteNode(texture: idleFrames[0])
        player.xScale = PlayerConfig().playerScale
        player.yScale = PlayerConfig().playerScale
        // Animate the archer with the frames at a set speed (0.1 seconds per frame)
        player.run(SKAction.repeatForever(SKAction.animate(with: idleFrames, timePerFrame: PlayerConfig().idleSAnimationSpeed)))
        
        // Set up physics body for the archer
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = Common.PhysicsCategory.player
        player.physicsBody?.contactTestBitMask = Common.PhysicsCategory.monster
        player.physicsBody?.collisionBitMask = Common.PhysicsCategory.none // No physical collision, only contact
        player.physicsBody?.isDynamic = true // Allow movement if needed
        player.physicsBody?.affectedByGravity = false // Since it's a 2D game, gravity is often disabled
        
        return player
    }
    
    func loadPlayerIdleSFrames() -> [SKTexture]{
        // Create an array to hold the animation frames
        let figureStand = UIImage(systemName: "figure.wave")!
        let figureStand2 = UIImage(systemName: "figure.arms.open")!
        let figureStand3 = UIImage(systemName: "figure")!
        let idleFrames: [SKTexture] = [SKTexture(image: figureStand),SKTexture(image: figureStand2),SKTexture(image: figureStand3)]

        // Assuming you have 4 images for the walking animation
        //for i in 1...4 {
        //    let textureName = PlayerConfig().idleSPlayerAsset + String(i)
        //    let texture = SKTexture(imageNamed: textureName)
        //    idleFrames.append(texture)
        //}

        return idleFrames
    }
}
