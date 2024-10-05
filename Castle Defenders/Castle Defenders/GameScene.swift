//
//  GameScene.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func sceneDidLoad() {
        let player = PlayerHandling().CreatePlayer()
        var monster = SKSpriteNode()
        let spawnMonsterAction = SKAction.run {
            monster = MonsterHandling().spawnMonster()
            self.addChild(monster)
            MonsterHandling().moveMonsterToPlayer(monster: monster, player: player)
        }
        let waitAction = SKAction.wait(forDuration: MonsterConfig().monsterSpawnSpeed) // Set delay between each monster spawn
        let spawnSequence = SKAction.sequence([spawnMonsterAction, waitAction])
        let spawnForever = SKAction.repeatForever(spawnSequence)

        self.physicsWorld.contactDelegate = self
        // Add the archer to the scene
        self.addChild(player)
        self.run(spawnForever)
    }
    
    // This function gets called when a collision/contact occurs
    func didBegin(_ contact: SKPhysicsContact) {
        // Sort the bodies involved in the collision
        let firstBody: SKPhysicsBody
        let secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // Check if it's a collision between the archer and a monster
        if firstBody.categoryBitMask == Common.PhysicsCategory.player && secondBody.categoryBitMask == Common.PhysicsCategory.monster {
            // Handle what happens on collision (e.g., reduce health, remove monster, etc.)
            MonsterHandling().MonsterDestroyed(in: self, monster: secondBody.node as! SKSpriteNode)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
