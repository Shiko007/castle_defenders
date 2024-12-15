//
//  GoldHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 20.10.24.
//
import SpriteKit

public class GoldHandling {
    func handleGoldCollect(player: PlayerNode, goldNode: GoldNode)
    {
        player.gold = player.gold + goldNode.amount
        //goldNode.removeFromParent()
        moveGoldTowardsPlayer(player: player,goldNode: goldNode)
    }
    
    func moveGoldTowardsPlayer(player: PlayerNode,goldNode: GoldNode) {
        // Get the player's current position
        let playerPosition = player.position
        
        // Create an action to move the gold drop to the player's position
        let moveAction = SKAction.move(to: playerPosition, duration: 0.2) // Adjust the duration as needed
        
        // Create an action to remove the gold drop after it reaches the player
        let removeAction = SKAction.run {
            goldNode.removeFromParent()
            
            // Increase the player's gold count
            player.gold += goldNode.amount
        }
        
        // Run both actions sequentially
        goldNode.run(SKAction.sequence([moveAction, removeAction]))
    }
}
