//
//  GameScene.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    let playerHandler = PlayerHandling()
    let monsterHandler = MonsterHandling()
    var sceneLoaded = false
    var player: PlayerNode?
    var monsters: [MonsterNode] = []
    
    override func sceneDidLoad() {
        sceneLoaded = true
        player = playerHandler.CreatePlayer(gameScene: self)
        var monster : MonsterNode?
        let spawnMonsterAction = SKAction.run {
            monster = self.monsterHandler.spawnMonster(gameScene: self)
            self.addChild(monster!)
            self.monsters.append(monster!)
            self.monsterHandler.moveMonsterToPlayer(monster: monster!, player: self.player!)
        }
        let waitAction = SKAction.wait(forDuration: MonsterConfig().monsterSpawnSpeed) // Set delay between each monster spawn
        let spawnSequence = SKAction.sequence([spawnMonsterAction, waitAction])
        let spawnForever = SKAction.repeatForever(spawnSequence)

        self.physicsWorld.contactDelegate = self
        // Add the archer to the scene
        self.run(spawnForever)
        self.addChild(player!)
    }
    
    // This function gets called when a collision/contact occurs
    func didBegin(_ contact: SKPhysicsContact) {
        // Sort the bodies involved in the collision
        let collisionHandling = CollisionHandling()
        collisionHandling.handleCollision(contact: contact)
    }
    
    func removeMonsterFromList(monster: MonsterNode){
        monsters.removeAll { $0 == monster }
    }
    
    // Update function is called every frame
    override func update(_ currentTime: TimeInterval) {
        if !sceneLoaded {
            return
        }
        // Call the update function of the PlayerNode
        player!.update(currentTime: currentTime, monsters: monsters)
        // You can update other game logic here as well
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
}
