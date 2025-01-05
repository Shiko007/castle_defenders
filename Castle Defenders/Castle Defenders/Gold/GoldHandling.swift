//
//  GoldHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 20.10.24.
//
import SpriteKit

public class GoldHandling {
    let goldConfig = GoldConfig()
    func handleGoldCollect(player: PlayerNode, goldNode: GoldNode, scene: GameScene)
    {
        moveGoldTowardsPlayer(player: player,goldNode: goldNode, scene: scene)
    }
    
    func moveGoldTowardsPlayer(player: PlayerNode,goldNode: GoldNode, scene: GameScene) {
        // Get the player's current position
        let playerPosition = player.position
        
        // Create an action to move the gold drop to the player's position
        let moveAction = SKAction.move(to: playerPosition, duration: 0.2) // Adjust the duration as needed
        
        // Create an action to remove the gold drop after it reaches the player
        let removeAction = SKAction.run {
            goldNode.removeFromParent()
            if(PlayerConfig.showCollectedGold){
                self.showGoldFeedback(amount: goldNode.amount, at: playerPosition, scene: scene)
            }
            // Increase the player's gold count
            player.gold += goldNode.amount
            player.savePlayerState()
            scene.uiHandling.goldCounterLabel.text = "\(player.gold)"
        }
        
        // Run both actions sequentially
        goldNode.run(SKAction.sequence([moveAction, removeAction]))
    }
    
    func showGoldFeedback(amount: Int, at playerPosition: CGPoint,scene: GameScene) {
        // Create the label node
        let goldLabel = SKLabelNode(text: "+\(amount)")
        // Randomize the starting position within a range above the player's head
        let xOffset = CGFloat.random(in: -20...20) // Random horizontal offset
        let yOffset = CGFloat.random(in: 30...50) // Random vertical range
        goldLabel.zPosition = elementsZPos.collectedGoldLabel
        goldLabel.fontName = goldConfig.goldFBFontName
        goldLabel.fontSize = goldConfig.goldFBLabelTextSize
        goldLabel.fontColor = goldConfig.goldFBFontColor
        goldLabel.position = CGPoint(x: playerPosition.x + xOffset, y: playerPosition.y + yOffset)

        // Add the label to the scene
        scene.addChild(goldLabel)

        // Create the move-up action
        let moveUp = SKAction.moveBy(x: 0, y: 50, duration: 0.5)

        // Create the fade-out action
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)

        // Group the actions
        let group = SKAction.group([moveUp, fadeOut])

        // Sequence to run the animation and remove the label
        let sequence = SKAction.sequence([group, .removeFromParent()])

        // Run the actions
        goldLabel.run(sequence)
    }
    
    func createGoldLabel(view : SKView, scene : GameScene) -> SKLabelNode {
        let goldLabel = SKLabelNode(text: goldConfig.goldCounterLabel)
        
        goldLabel.fontName = goldConfig.goldLabelFont
        goldLabel.fontSize = goldConfig.goldLabelFontSize
        goldLabel.fontColor = goldConfig.goldLabelColor
        goldLabel.zPosition = elementsZPos.goldLabel // Ensure it's on top of other nodes
        
        // Position the label in the top-left corner based on the converted point
        goldLabel.position = scene.convertPoint(fromView: CGPoint(x: view.bounds.maxX - goldLabel.frame.width * 3 , y: view.bounds.maxY - goldLabel.frame.height * 2))
        //monstersKilledLabel.position = monsterConfiguration.killedMonsLabelPos
        return goldLabel
    }
}
