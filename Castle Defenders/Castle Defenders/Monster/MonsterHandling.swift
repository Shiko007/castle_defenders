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
    
    func CreateMonster(gameScene: GameScene,direction: Direction,player: PlayerNode) -> MonsterNode{
        let movingFrames = self.loadMonsterMovingFrames(direction: direction)
        // Create your Monster
        let monster = MonsterNode(texture: movingFrames[0], size: CGSize(width: monsterConfiguration.monsterWidth, height: monsterConfiguration.monsterHeight), gameScene: gameScene, player: player, expWorth: monsterConfiguration.monsterExpWorth)
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
    }
    
    func spawnMonster(gameScene: GameScene, player : PlayerNode) -> MonsterNode {
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
            monster = self.CreateMonster(gameScene: gameScene,direction: .left,player: player)
            // Set monster's initial position
            monster!.position = position
        }else{
            monster = self.CreateMonster(gameScene: gameScene,direction: .right,player: player)
            // Set monster's initial position
            monster!.position = position
        }
        return monster!
    }
    
    func moveMonsterToPlayer(monster: MonsterNode,player: PlayerNode) {
        // Get the archer's position (assuming archer is placed in the center of the screen)
        let playerPosition = player.position
        
        // Define the fixed movement speed (e.g., 100 points per second)
        let movementSpeed: CGFloat = monsterConfiguration.monsterMovmentSpeed
        
        // Calculate the distance between the monster and the player
        let distance = hypot(monster.position.x - playerPosition.x, monster.position.y - playerPosition.y)
        
        // Calculate the time it will take to cover the distance at the given speed
        let duration = distance / movementSpeed
        
        // Create the move action to the player's position
        let moveAction = SKAction.move(to: playerPosition, duration: TimeInterval(duration))
        
        // Run the move action on the monster
        monster.run(moveAction)
    }
    
    func createKilledMonstersLabel(view : SKView, scene : SKScene) -> SKLabelNode {
        let monstersKilledLabel = SKLabelNode(text: monsterConfiguration.killedMonsCounterLabel)
        
        monstersKilledLabel.fontName = monsterConfiguration.killedMonsLabelFont
        monstersKilledLabel.fontSize = monsterConfiguration.killedMonsLabelFontSize
        monstersKilledLabel.fontColor = monsterConfiguration.killedMonsLabelColor
        monstersKilledLabel.zPosition = elementsZPos.monstersKilledLabel // Ensure it's on top of other nodes
        
        // Position the label in the top-left corner based on the converted point
        monstersKilledLabel.position = scene.convertPoint(fromView: CGPoint(x: view.bounds.minX + monstersKilledLabel.frame.width * 3 , y: view.bounds.maxY - monstersKilledLabel.frame.height * 2))
        //monstersKilledLabel.position = monsterConfiguration.killedMonsLabelPos
        return monstersKilledLabel
    }
}
