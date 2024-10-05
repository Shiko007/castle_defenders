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
        let archer = SKSpriteNode(texture: idleFrames[0])
        archer.xScale = PlayerConfig().playerScale
        archer.yScale = PlayerConfig().playerScale
        // Animate the archer with the frames at a set speed (0.1 seconds per frame)
        archer.run(SKAction.repeatForever(SKAction.animate(with: idleFrames, timePerFrame: PlayerConfig().idleSAnimationSpeed)))
        return archer
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
