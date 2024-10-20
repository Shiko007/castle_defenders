//
//  MonsterNode.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 08.10.24.
//

import SpriteKit

class MonsterNode: SKSpriteNode {
    let monsterConfiguration = MonsterConfig()
    let playerConfiguration = PlayerConfig()
    let goldHandling = GoldHandling()
    var monsterSpeed : CGFloat!
    var maxHealth: Int!
    var health: Int!
    var oldHealth: Int!
    var id: UUID = UUID()
    var gameScene: GameScene!
    var healthBar: SKSpriteNode!
    var player : PlayerNode!
    var expWorth : Int!
    
    init(texture: SKTexture?, color: UIColor = .clear, size: CGSize = CGSize(width: 50, height: 50), gameScene: GameScene, player : PlayerNode, expWorth: Int) {
        self.gameScene = gameScene
        // You must call a designated initializer of SKSpriteNode here
        super.init(texture: texture, color: color, size: size)  // Correct designated initializer call
        
        // Set up the physics body for the monster
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.categoryBitMask = PhysicsCategory.monster
        // Detect collisions with both attacks and the player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
        self.zPosition = elementsZPos.monsters
        self.player = player
        self.expWorth = expWorth
        self.maxHealth = monsterConfiguration.monsterMaxHealth
        self.health = maxHealth
        self.oldHealth = health
        self.monsterSpeed = monsterConfiguration.monsterMovmentSpeed
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
        healthBarBackground.zPosition = elementsZPos.monstersHealthbarZPos  // Ensure it's rendered above the monster
        addChild(healthBarBackground)
        
        // Foreground bar (green)
        healthBar = SKSpriteNode(color: monsterConfiguration.healthbarFGColor, size: CGSize(width: barWidth, height: barHeight))
        healthBar.anchorPoint = CGPoint(x: 0.0, y: 0.5)  // Anchor on the right side (x = 1)
        healthBar.position = CGPoint(x: -barWidth / 2, y: 0)  // Set the position to match the right side of the background
        healthBar.zPosition = elementsZPos.monstersHealthbarFGZPos  // Above the background
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
        if(oldHealth > 0){
            if health <= 0 {
                //Monster is defeated
                self.MonsterDestroyed()
            }
        }
        oldHealth = health
    }
    
    func MonsterDestroyed(){
        // Create and position the smoke effect
        if let smokeEffect = SKEmitterNode(fileNamed: "enemy_destroyed.sks") {
            smokeEffect.position = self.position
            self.parent?.addChild(smokeEffect)
            smokeEffect.zPosition = elementsZPos.monsterDestroyedEffect
            // Optional: Run a sequence to remove the smoke effect after it dissipates
            let wait = SKAction.wait(forDuration: 3.0) // Adjust duration as needed
            let removeSmoke = SKAction.removeFromParent()
            smokeEffect.run(SKAction.sequence([wait, removeSmoke]))
        }
        // Generate the gold drop at the monster's location
        let goldDrop = GoldNode(position: self.position, minValue: 1,maxValue: 10)
        // Add a removal after a few seconds
        let goldWait = SKAction.wait(forDuration: 5.0)
        let goldRemove = SKAction.removeFromParent()
        // Remove the monster from the scene
        gameScene.removeMonsterFromList(monster: self)
        gameScene.incrementMonstersKilled()
        player.gainExperience(points: expWorth)
        gameScene.addChild(goldDrop)
        goldDrop.run(SKAction.sequence([goldWait, goldRemove]))
        if(playerConfiguration.autoCollectGold == true){
            goldHandling.handleGoldCollect(player: player, goldNode: goldDrop)
        }
        self.removeFromParent()
    }
}
