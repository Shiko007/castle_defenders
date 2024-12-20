//
//  CollisionHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 09.10.24.
//

import SpriteKit

class CollisionHandling {
    func handleCollision(contact: SKPhysicsContact){
        let firstBody: SKPhysicsBody
        let secondBody: SKPhysicsBody
        // Sort bodies to ensure consistency
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // Monster hits Player
        if firstBody.categoryBitMask == PhysicsCategory.monster && secondBody.categoryBitMask == PhysicsCategory.player {
            if let monster = firstBody.node as? MonsterNode {
                //player.takeDamage(amount: 10)  // Deal damage to player when hit
                monster.MonsterDestroyed()  // Optional: Remove the monster after hitting the player
            }
        }
    }
}
