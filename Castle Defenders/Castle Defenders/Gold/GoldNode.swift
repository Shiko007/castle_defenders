//
//  GoldDrop.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 20.10.24.
//
import SpriteKit

class GoldNode : SKSpriteNode {
    var amount: Int!
    init(position: CGPoint, minValue : Int, maxValue : Int) {
        let goldImage = UIImage(systemName: "dollarsign.ring.dashed")!
        let texture = SKTexture(image: goldImage) // Make sure to have a gold coin asset
        let size = CGSize(width: 30, height: 30) // Adjust the size as needed
        amount = Int.random(in: minValue ... maxValue)
        super.init(texture: texture, color: .clear, size: size)
        self.zPosition = elementsZPos.goldDrops
        self.position = position
        self.name = "goldDrop"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
