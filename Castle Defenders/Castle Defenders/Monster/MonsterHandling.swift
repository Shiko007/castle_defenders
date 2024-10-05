//
//  MonsterHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//

import GameplayKit

public class MonsterHandling{
    enum Direction {
        case left
        case right
    }
    func CreateMonster(direction: Direction) -> SKSpriteNode{
        let movingFrames = self.loadMonsterMovingFrames(direction: direction)
        // Create your SKSpriteNode (your archer character)
        let monster = SKSpriteNode(texture: movingFrames[0])
        monster.xScale = MonsterConfig().monsterScale
        monster.yScale = MonsterConfig().monsterScale
        // Animate the archer with the frames at a set speed (0.1 seconds per frame)
        monster.run(SKAction.repeatForever(SKAction.animate(with: movingFrames, timePerFrame: MonsterConfig().monsterAnimationSpeed)))
        
        // Set up physics body for the archer
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size)
        monster.physicsBody?.categoryBitMask = Common.PhysicsCategory.monster
        monster.physicsBody?.contactTestBitMask = Common.PhysicsCategory.player
        monster.physicsBody?.collisionBitMask = Common.PhysicsCategory.none // No physical collision, only contact
        monster.physicsBody?.isDynamic = false // Allow movement if needed
        monster.physicsBody?.affectedByGravity = false // Since it's a 2D game, gravity is often disabled
        
        return monster
    }
    
    func loadMonsterMovingFrames(direction: Direction) -> [SKTexture]{
        switch direction {
        case .left:
            let figureStand = UIImage(systemName: "figure.bowling")!
            let figureStand2 = UIImage(systemName: "figure.basketball")!
            let figureStand3 = UIImage(systemName: "figure")!
            let Frames: [SKTexture] = [SKTexture(image: figureStand),SKTexture(image: figureStand2),SKTexture(image: figureStand3)]
            return Frames
        case .right:
            let figureStand = UIImage(systemName: "figure.walk")!
            let figureStand2 = UIImage(systemName: "figure.run")!
            let figureStand3 = UIImage(systemName: "figure")!
            let Frames: [SKTexture] = [SKTexture(image: figureStand),SKTexture(image: figureStand2),SKTexture(image: figureStand3)]
            return Frames
        }

        // Assuming you have 4 images for the walking animation
        //for i in 1...4 {
        //    let textureName = PlayerConfig().idleSPlayerAsset + String(i)
        //    let texture = SKTexture(imageNamed: textureName)
        //    idleFrames.append(texture)
        //}
    }
    
    func spawnMonster() -> SKSpriteNode {
        // Get screen bounds
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // Randomly choose an edge (top, bottom, left, right)
        let edge = Int.random(in: 0..<4)
        var position: CGPoint
        var monster = SKSpriteNode()
        
        switch edge {
        case 0: // Top edge
            position = CGPoint(x: CGFloat.random(in: -screenWidth...screenWidth), y: screenHeight)
        case 1: // Bottom edge
            position = CGPoint(x: CGFloat.random(in: -screenWidth...screenWidth), y: -screenHeight)
        case 2: // Left edge
            position = CGPoint(x: -screenWidth, y: CGFloat.random(in: -screenHeight...screenHeight))
        case 3: // Right edge
            position = CGPoint(x: screenWidth, y: CGFloat.random(in: -screenHeight...screenHeight))
        default:
            position = CGPoint.zero
        }
        
        if(position.x < 0){
            monster = self.CreateMonster(direction: .left)
            // Set monster's initial position
            monster.position = position
        }else{
            monster = self.CreateMonster(direction: .right)
            // Set monster's initial position
            monster.position = position
        }
        return monster
    }
    
    func moveMonsterToPlayer(monster: SKSpriteNode,player: SKSpriteNode) {
        // Get the archer's position (assuming archer is placed in the center of the screen)
        let playerPosition = player.position
        
        // Create a movement action to move towards the archer
        let moveAction = SKAction.move(to: playerPosition, duration: MonsterConfig().monsterMovmentSpeed) // Adjust the duration as needed
        
        // Make the monster move to the archer
        monster.run(moveAction)
    }
    
    func MonsterDestroyed(in scene: SKScene,monster: SKSpriteNode){
        // Create and position the smoke effect
        if let smokeEffect = SKEmitterNode(fileNamed: "enemy_destroyed.sks") {
            smokeEffect.position = monster.position
            scene.addChild(smokeEffect)
            
            // Optional: Run a sequence to remove the smoke effect after it dissipates
            let wait = SKAction.wait(forDuration: 3.0) // Adjust duration as needed
            let removeSmoke = SKAction.removeFromParent()
            smokeEffect.run(SKAction.sequence([wait, removeSmoke]))
        }
        
        // Remove the monster from the scene (simulating explosion)
        monster.removeFromParent()
    }
}
