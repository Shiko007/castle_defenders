//
//  MonsterNode.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 08.10.24.
//

import SpriteKit

class MonsterNode: SKSpriteNode {
    let monsterConfiguration = MonsterConfig()
    var maxHealth: Int = 40
    var health: Int = 40
    var id: UUID = UUID()
    var gameScene: GameScene?
    var healthBar: SKSpriteNode!
    
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
        self.physicsBody?.affectedByGravity = false
        
        // Create the health bar
        createHealthBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createHealthBar() {
        let barWidth = size.width
        let barHeight: CGFloat = 5

        // Background bar (gray)
        let healthBarBackground = SKSpriteNode(color: monsterConfiguration.healthbarBGColor, size: CGSize(width: barWidth, height: barHeight))
        healthBarBackground.position = CGPoint(x: 0, y: size.height / 2 + monsterConfiguration.healthbarDistanceFromMonster) // Position above the monster
        healthBarBackground.zPosition = monsterConfiguration.healthbarZPos  // Ensure it's rendered above the monster
        addChild(healthBarBackground)
        
        // Foreground bar (green)
        healthBar = SKSpriteNode(color: monsterConfiguration.healthbarFGColor, size: CGSize(width: barWidth, height: barHeight))
        healthBar.anchorPoint = CGPoint(x: 0.0, y: 0.5)  // Anchor on the right side (x = 1)
        healthBar.position = CGPoint(x: -barWidth / 2, y: 0)  // Set the position to match the right side of the background
        healthBar.zPosition = monsterConfiguration.healthbarFGZPos  // Above the background
        healthBarBackground.addChild(healthBar)
    }
    
    // Update the health bar when the monster takes damage
    func updateHealthBar() {
        let healthPercentage = CGFloat(health) / CGFloat(maxHealth)
        let barWidth = size.width * healthPercentage
        healthBar.size.width = barWidth  // Adjust the width of the health bar
        //healthBar.position = CGPoint(x: -(size.width * (1 - healthPercentage)) / 2, y: 0)
    }

    func takeDamage(amount: Int) {
        health -= amount
        
        // Update the health bar
        updateHealthBar()
        
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
        gameScene?.incrementMonstersKilled()
        self.removeFromParent()
    }
}
