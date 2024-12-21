//
//  AttackNode.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 09.10.24.
//
import SpriteKit

class AttackNode: SKSpriteNode {
    let playerConfiguration = PlayerConfig()
    let attackConfig = AttackConfig()
    var target : MonsterNode!
    var damage : Int!
    init(texture: SKTexture?, size: CGSize = CGSize(width: 10, height: 10), targetMonster : MonsterNode, damage: Int) {
        super.init(texture: texture, color: .clear, size: size)
        self.target = targetMonster
        self.damage = damage
        // You can add velocity or any other movement logic here
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateNode (scene: GameScene) {
        let distance = hypot(self.position.x - target.position.x, self.position.y - target.position.y)
        let hitThreshold: CGFloat = playerConfiguration.attackThreashold // Define a distance threshold for hit detection

        if distance < hitThreshold {
            target.takeDamage(amount: damage) // Apply damage
            if(playerConfiguration.showAttackDamage){
                showDamageFeedback(amount: damage, at: target.position, scene: scene)
            }
            self.removeFromParent() // Remove the projectile after hit
        }
    }
    
    func showDamageFeedback(amount: Int, at monsterPosition: CGPoint, scene: GameScene) {
        // Create the label node
        let damageLabel = SKLabelNode(text: "-\(amount)")
        damageLabel.fontName = attackConfig.dmgFBFontName
        damageLabel.fontSize = attackConfig.dmgFBLabelTextSize
        damageLabel.fontColor = attackConfig.dmgFBFontColor
        damageLabel.position = CGPoint(x: monsterPosition.x, y: monsterPosition.y + 30)
        // Add the label to the scene
        scene.addChild(damageLabel)

        // Create the move-up action
        let moveUp = SKAction.moveBy(x: 0, y: 40, duration: 0.5)

        // Create the fade-out action
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)

        // Group the actions
        let group = SKAction.group([moveUp, fadeOut])

        // Sequence to run the animation and remove the label
        let sequence = SKAction.sequence([group, .removeFromParent()])

        // Run the actions
        damageLabel.run(sequence)
    }
}
