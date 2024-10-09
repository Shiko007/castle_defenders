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
    
    let monsterConfiguration = MonsterConfig()
    
    func CreateMonster(gameScene: GameScene,direction: Direction) -> MonsterNode{
        let movingFrames = self.loadMonsterMovingFrames(direction: direction)
        // Create your Monster
        let monster = MonsterNode(texture: movingFrames[0], gameScene: gameScene)
        // Animate with the frames at a set speed (0.1 seconds per frame)
        monster.run(SKAction.repeatForever(SKAction.animate(with: movingFrames, timePerFrame: monsterConfiguration.monsterAnimationSpeed)))
        
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
    
    func spawnMonster(gameScene: GameScene) -> MonsterNode {
        // Get screen bounds
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // Randomly choose an edge (top, bottom, left, right)
        let edge = Int.random(in: 0..<4)
        var position: CGPoint
        var monster : MonsterNode?
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
            monster = self.CreateMonster(gameScene: gameScene,direction: .left)
            // Set monster's initial position
            monster!.position = position
        }else{
            monster = self.CreateMonster(gameScene: gameScene,direction: .right)
            // Set monster's initial position
            monster!.position = position
        }
        return monster!
    }
    
    func moveMonsterToPlayer(monster: SKSpriteNode,player: SKSpriteNode) {
        // Get the archer's position (assuming archer is placed in the center of the screen)
        let playerPosition = player.position
        
        // Create a movement action to move towards the archer
        let moveAction = SKAction.move(to: playerPosition, duration: MonsterConfig().monsterMovmentSpeed) // Adjust the duration as needed
        
        // Make the monster move to the archer
        monster.run(moveAction)
    }
}
