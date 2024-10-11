//
//  PlayerNode.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 08.10.24.
//

import SpriteKit

class PlayerNode: SKSpriteNode {
    let playerConfiguration = PlayerConfig()
    var attackCooldown: TimeInterval = 1 // Time between attacks initial value
    var lastAttackTime: TimeInterval = 0 // Track the last attack time
    var attackRange: CGFloat = 50 // Range within which the player can attack inital value
    var gameScene: GameScene?
    
    init(texture: SKTexture?, color: UIColor = .clear, size: CGSize = CGSize(width: 50, height: 50), gameScene: GameScene) {
        self.gameScene = gameScene
        // You must call a designated initializer of SKSpriteNode here
        super.init(texture: texture, color: color, size: size)  // Correct designated initializer call
        
        self.attackCooldown = playerConfiguration.attackCD
        self.attackRange = playerConfiguration.attackRange
        
        // Set up physics body for the player
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = PhysicsCategory.player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.monster
        self.physicsBody?.collisionBitMask = PhysicsCategory.none // No physical collision, only contact
        self.physicsBody?.isDynamic = true // Allow movement if needed
        self.physicsBody?.affectedByGravity = false // Since it's a 2D game, gravity is often disabled
        
        addPlayerRangeCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPlayerRangeCircle() {
        let player = self
        let radius: CGFloat = playerConfiguration.attackRange
        
        // Create a circular shape node with the given radius
        let rangeCircle = SKShapeNode(circleOfRadius: radius)
        
        // Set the fill color to gray with low opacity
        rangeCircle.fillColor = UIColor.gray.withAlphaComponent(playerConfiguration.playerRangeColorAlpha)
        
        // Optionally, set the stroke color and width (for the circle's border)
        rangeCircle.strokeColor = playerConfiguration.playerRangeColor
        rangeCircle.lineWidth = playerConfiguration.playerRangeLineW
        
        // Position the circle at the player's position
        rangeCircle.position = player.position
        
        // Ensure the circle is behind the player (optional, adjust zPosition as needed)
        rangeCircle.zPosition = player.zPosition - 1
        
        // Add the circle to the scene (or the player node if you prefer)
        gameScene!.addChild(rangeCircle)
    }
    
    func update(currentTime: TimeInterval, monsters: [MonsterNode]) {
        // Find the closest monster within attack range
        var distance : CGFloat!
        let sortedMonsters = sortMonsters(monsters)
        var attackableMonsters : [MonsterNode] = []
        for monster in sortedMonsters {
            distance = distanceBetween(player: self, monster: monster)
            
            if distance <= attackRange && attackableMonsters.count <= playerConfiguration.attackCount {
                // Perform attack
                attackableMonsters.append(monster)
            }
        }
        if currentTime - lastAttackTime >= attackCooldown {
            attack(monsters: attackableMonsters)
            lastAttackTime = currentTime
        }
    }
    
    func sortMonsters(_ monsters: [MonsterNode]) -> [MonsterNode] {
        // Sort monsters by distance and return the closest one
        return monsters.sorted {
            distanceBetween(player: self, monster: $0) < distanceBetween(player: self, monster: $1)
            }
    }
    
    func distanceBetween(player: PlayerNode, monster: MonsterNode) -> CGFloat {
        let dx = player.position.x - monster.position.x
        let dy = player.position.y - monster.position.y
        return sqrt(dx*dx + dy*dy)
    }
    
    func attack(monsters: [MonsterNode]) {
        //TODO: Handle number of projectiles required to kill a target
        // Attack animation (e.g., shoot an arrow)
        let attackImage = SKTexture(image: UIImage(systemName: "arrow.trianglehead.swap")!)
        for monster in monsters {
            let attack = AttackNode(texture:attackImage, targetMonster: monster, damage: playerConfiguration.attackDamage)
            
            attack.position = self.position
            let moveAction = SKAction.move(to: monster.position, duration: playerConfiguration.attackProjectileSpeed)
            let removeAction = SKAction.removeFromParent()
            attack.run(SKAction.sequence([moveAction, removeAction]))
            
            self.parent?.addChild(attack)
        }
        
        // Apply damage to the monster
        //monster.takeDamage(amount: 10) // Adjust damage amount
    }
}
