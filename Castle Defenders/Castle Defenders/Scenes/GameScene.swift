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
    let common = Common()
    var sceneLoaded = false
    var player: PlayerNode?
    var monsters: [MonsterNode] = []
    var monstersKilled: Int = 0
    var killedCounterLabel : SKLabelNode!
    var subMenu: SKNode!
    
    override func sceneDidLoad() {
        self.backgroundColor = common.gameSceneBGColor
        sceneLoaded = true
        player = playerHandler.CreatePlayer(gameScene: self)
        var monster : MonsterNode?
        let spawnMonsterAction = SKAction.run {
            monster = self.monsterHandler.spawnMonster(gameScene: self, player: self.player!)
            self.addChild(monster!)
            self.monsters.append(monster!)
            self.monsterHandler.moveMonsterToPlayer(monster: monster!, player: self.player!)
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
        killedCounterLabel.text = String(monstersKilled)
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
                attackNode.updateNode()
            }
        }
        // You can update other game logic here as well
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        let menuButton = common.createButton(withText: "I", name: "menuButton", size: CGSize(width: 50, height: 50), position: self.convertPoint(fromView: CGPoint(x: view.bounds.minX + 50, y: view.bounds.minY + 50)))
        subMenu = common.createSubmenu(view: view, scene: self)
        killedCounterLabel = monsterHandler.createKilledMonstersLabel(view : view, scene : self)
        self.addChild(menuButton)
        self.addChild(subMenu)
        subMenu.isHidden = true
        self.addChild(killedCounterLabel)
    }
    
    func toggleSubmenu() {
            // Show or hide the submenu
        subMenu.isHidden = !subMenu.isHidden
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if touchedNode.name == "menuButton" {
                //Display SubMenu
                toggleSubmenu()
            }
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
