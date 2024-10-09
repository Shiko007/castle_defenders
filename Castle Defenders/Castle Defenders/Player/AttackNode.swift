//
//  AttackNode.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 09.10.24.
//
import SpriteKit

class AttackNode: SKSpriteNode {
    init(texture: SKTexture?, size: CGSize = CGSize(width: 10, height: 10)) {
        super.init(texture: texture, color: .clear, size: size)
        
        // Set up the physics body for the arrow
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.categoryBitMask = PhysicsCategory.attack
        self.physicsBody?.contactTestBitMask = PhysicsCategory.monster
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.physicsBody?.isDynamic = true
        
        // You can add velocity or any other movement logic here
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
