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
    let monsterHandling = MonsterHandling()
    let goldHandling = GoldHandling()
    let mapsHandling = MapsHandling()
    let menuHandling = MenuHandling()
    let shopHandling = ShopHandling()
    let uiHandling = UIHandling()
    let common = Common()
    var sceneLoaded = false
    var player: PlayerNode!
    var monsters: [MonsterNode] = []
    var monstersKilled: Int = 0
    
    override func sceneDidLoad() {
        self.backgroundColor = common.gameSceneBGColor
        sceneLoaded = true
        player = playerHandler.CreatePlayer(gameScene: self)
        var monster : MonsterNode?
        let spawnMonsterAction = SKAction.run {
            monster = self.monsterHandling.spawnMonster(gameScene: self, player: self.player!)
            self.addChild(monster!)
            self.monsters.append(monster!)
            self.monsterHandling.moveMonsterToPlayer(monster: monster!, player: self.player!)
        }
        let waitAction = SKAction.wait(forDuration: MonsterConfig().monsterSpawnSpeed) // Set delay between each monster spawn
        let spawnSequence = SKAction.sequence([spawnMonsterAction, waitAction])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        
        self.physicsWorld.contactDelegate = self
        // Add the player to the scene
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
    
    // Function to update the monsters killed counter
    func incrementMonstersKilled() {
        monstersKilled += 1
        uiHandling.killedCounterLabel.text = String(monstersKilled)
    }
    
    // Update function is called every frame
    override func update(_ currentTime: TimeInterval) {
        if !sceneLoaded {
            return
        }
        // Call the update function of the PlayerNode
        player!.update(currentTime: currentTime, monsters: monsters)
        for node in self.children {
            if node is AttackNode {
                let attackNode = node as! AttackNode
                attackNode.updateNode(scene: self)
            }
        }
        // You can update other game logic here as well
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        uiHandling.showUI(scene: self, view: view)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            common.handleTouch(touch: touch, scene: self)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
