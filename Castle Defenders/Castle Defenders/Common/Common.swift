//
//  Common.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//

import SpriteKit

public class Common {
    let gameSceneBGColor: UIColor = .white
    
    // Create a button with a border
    func createButton(withText text: String,name: String, size: CGSize, position: CGPoint) -> SKNode {
        let buttonNode = SKNode()
        
        // Create the background as a shape node with a border
        let buttonBackground = SKShapeNode(rectOf: size, cornerRadius: 10)
        buttonBackground.fillColor = .clear
        buttonBackground.strokeColor = .black // Border color
        buttonBackground.lineWidth = 2 // Border thickness
        buttonBackground.name = name
        
        // Create the label
        let label = SKLabelNode(text: text)
        label.fontSize = 28
        label.fontColor = .black
        label.position = CGPoint(x: 0, y: -label.frame.size.height / 2)
        label.name = name
        
        // Position the button and add background + label
        buttonNode.position = position
        buttonNode.addChild(buttonBackground)
        buttonNode.addChild(label)
        
        return buttonNode
    }
}

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let monster: UInt32 = 0b1  // 1
    static let player: UInt32 = 0b10 // 2
}
