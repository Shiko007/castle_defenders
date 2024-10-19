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
        buttonNode.zPosition = elementsZPos.menuButton
        buttonNode.position = position
        buttonNode.addChild(buttonBackground)
        buttonNode.addChild(label)
        
        return buttonNode
    }
    
    func createSubmenu(view: SKView,scene: SKScene) -> SKNode {
        // Create a container node for the submenu
        let submenu = SKNode()
        submenu.zPosition = elementsZPos.submenu
        
        // Example: Add a few submenu items
        let option1 = self.createButton(withText: "Option 1", name: "subMenu_Op1", size: CGSize(width: 150, height: 50), position: CGPoint(x: 0, y: 120))
        
        let option2 = self.createButton(withText: "Option 2", name: "subMenu_Op2", size: CGSize(width: 150, height: 50), position: CGPoint(x: 0, y: 60))
        
        let option3 = self.createButton(withText: "Option 3", name: "subMenu_Op3", size: CGSize(width: 150, height: 50), position: CGPoint(x: 0, y: 0))
        
        // Create the background as a shape node with a border
        let submenuBackground = SKShapeNode(rectOf: CGSize(width: 200, height: 200), cornerRadius: 10)
        submenuBackground.position = CGPoint(x: 0, y: option1.position.y / 2)
        submenuBackground.fillColor = .clear
        submenuBackground.strokeColor = .black // Border color
        submenuBackground.lineWidth = 2 // Border thickness
        
        submenu.position = scene.convertPoint(fromView: CGPoint(x: view.bounds.maxX / 2, y: (view.bounds.maxY / 2) - 200 ))
        
        submenu.addChild(submenuBackground)
        submenu.addChild(option1)
        submenu.addChild(option2)
        submenu.addChild(option3)
        return submenu
    }
}

struct elementsZPos {
    static let expCircleRange: CGFloat = -2
    static let expCircle: CGFloat = -1
    static let monstersHealthbarZPos: CGFloat = 1
    static let monstersHealthbarFGZPos: CGFloat = 2
    static let monstersKilledLabel: CGFloat = 10
    static let submenu: CGFloat = 11
    static let menuButton: CGFloat = 11
}

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let monster: UInt32 = 0b1  // 1
    static let player: UInt32 = 0b10 // 2
}
