//
//  MonsterNode.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 08.10.24.
//

import SpriteKit

class MonsterNode: SKSpriteNode {
    var health: Int = 10
    var id: UUID = UUID()
    var gameScene: GameScene?
    
    init(texture: SKTexture?, color: UIColor = .clear, size: CGSize = CGSize(width: 50, height: 50), gameScene: GameScene) {
        self.gameScene = gameScene
        // You must call a designated initializer of SKSpriteNode here
        super.init(texture: texture, color: color, size: size)  // Correct designated initializer call
        
        // Set up the physics body for the monster
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.categoryBitMask = PhysicsCategory.monster
        // Detect collisions with both attacks and the player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.attack | PhysicsCategory.player
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.physicsBody?.isDynamic = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func takeDamage(amount: Int) {
        health -= amount
        if health <= 0 {
            //Monster is defeated
            self.MonsterDestroyed()
        }
    }
    
    func MonsterDestroyed(){
        // Create and position the smoke effect
        if let smokeEffect = SKEmitterNode(fileNamed: "enemy_destroyed.sks") {
            smokeEffect.position = self.position
            self.parent?.addChild(smokeEffect)
            
            // Optional: Run a sequence to remove the smoke effect after it dissipates
            let wait = SKAction.wait(forDuration: 3.0) // Adjust duration as needed
            let removeSmoke = SKAction.removeFromParent()
            smokeEffect.run(SKAction.sequence([wait, removeSmoke]))
        }
        // Remove the monster from the scene (simulating explosion)
        gameScene?.removeMonsterFromList(monster: self)
        self.removeFromParent()
    }
}
