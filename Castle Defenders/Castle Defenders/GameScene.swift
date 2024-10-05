//
//  GameScene.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
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

        // Add the archer to the scene
        self.addChild(player)
        self.run(spawnForever)
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
