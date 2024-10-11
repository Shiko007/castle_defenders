//
//  AttackNode.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 09.10.24.
//
import SpriteKit

class AttackNode: SKSpriteNode {
    let playerConfiguration = PlayerConfig()
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

    func updateNode () {
        let distance = hypot(self.position.x - target.position.x, self.position.y - target.position.y)
        let hitThreshold: CGFloat = playerConfiguration.attackThreashold // Define a distance threshold for hit detection

        if distance < hitThreshold {
            target.takeDamage(amount: damage) // Apply damage
            self.removeFromParent() // Remove the projectile after hit
        }
    }
}
