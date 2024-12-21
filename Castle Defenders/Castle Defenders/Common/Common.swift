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
        buttonBackground.strokeColor = .gray // Border color
        buttonBackground.lineWidth = 5 // Border thickness
        buttonBackground.name = name
        
        // Create the label
        let label = SKLabelNode()
        label.attributedText = NSAttributedString(
                string: text,
                attributes: [
                    .font: UIFont.boldSystemFont(ofSize: 28),
                    .foregroundColor: UIColor.gray
                ]
            )
        label.position = CGPoint(x: 0, y: -label.frame.size.height / 2)
        label.name = name
        
        // Position the button and add background + label
        buttonNode.zPosition = elementsZPos.menuButton
        buttonNode.position = position
        buttonNode.addChild(buttonBackground)
        buttonNode.addChild(label)
        
        return buttonNode
    }
    
    func createSubmenu(view: SKView, scene: SKScene,
                       buttons: [(text: String, name: String)],
                       buttonSize: CGSize = CGSize(width: 150, height: 50),
                       buttonSeparation: CGFloat = 10) -> SKNode {
        // Create a container node for the submenu
        let submenu = SKNode()
        submenu.zPosition = elementsZPos.submenu

        // Determine the number of columns and rows
        let columns = 2
        let rows = Int(ceil(Double(buttons.count) / Double(columns)))

        // Calculate the total width and height of the submenu
        let totalWidth = CGFloat(columns) * buttonSize.width + CGFloat(columns - 1) * buttonSeparation
        let totalHeight = CGFloat(rows) * buttonSize.height + CGFloat(rows - 1) * buttonSeparation

        // Start position for the first button (top-left corner)
        let startX = -totalWidth / 2 + buttonSize.width / 2
        let startY = totalHeight / 2 - buttonSize.height / 2

        // Create buttons and add them to the submenu
        for (index, button) in buttons.enumerated() {
            let column = index % columns
            let row = index / columns

            let xPosition = startX + CGFloat(column) * (buttonSize.width + buttonSeparation)
            let yPosition = startY - CGFloat(row) * (buttonSize.height + buttonSeparation)

            let buttonNode = self.createButton(withText: button.text,
                                               name: button.name,
                                               size: buttonSize,
                                               position: CGPoint(x: xPosition, y: yPosition))
            buttonNode.zPosition = elementsZPos.submenuButton
            submenu.addChild(buttonNode)
        }

        // Create the background dynamically based on the total size
        let backgroundWidth = totalWidth + 40 // Add padding
        let backgroundHeight = totalHeight + 40 // Add padding
        let submenuBackground = SKShapeNode(rectOf: CGSize(width: backgroundWidth, height: backgroundHeight), cornerRadius: 10)
        submenuBackground.position = CGPoint(x: 0, y: 0)
        submenuBackground.fillColor = .gray
        submenuBackground.alpha = 0.5
        submenuBackground.strokeColor = .black // Border color
        submenuBackground.lineWidth = 5 // Border thickness
        submenuBackground.name = "submenuBackground"

        // Position the submenu in the center of the screen (or offset as needed)
        submenu.position = scene.convertPoint(fromView: CGPoint(x: view.bounds.midX, y: view.bounds.midY - 200))

        // Add background to the submenu
        submenu.addChild(submenuBackground)

        return submenu
    }
    
    func handleTouch(touch : UITouch, scene : GameScene) {
        let location = touch.location(in: scene)
        let touchedNode = scene.atPoint(location)
        switch touchedNode.name {
        case "menuButton":
            //Display SubMenu
            
            scene.uiHandling.teleportMenu.isHidden = true
            scene.uiHandling.toggleHidden(node: scene.uiHandling.subMenu)
            break
        case "teleportButton":
            //Display SubMenu
            scene.uiHandling.subMenu.isHidden = true
            scene.uiHandling.toggleHidden(node: scene.uiHandling.teleportMenu)
            break
        case "goldDrop":
            scene.goldHandling.handleGoldCollect(player: scene.player, goldNode: touchedNode as! GoldNode, scene: scene)
            break
        case "teleportMenu_Mine":
            //Submenu button pressed
            scene.mapsHandling.handleButtonPress(text: "teleportMenu_Mine")
            break
        case "teleportMenu_City":
            //Submenu button pressed
            scene.mapsHandling.handleButtonPress(text: "teleportMenu_City")
            break
        case "teleportMenu_Island":
            //Submenu button pressed
            scene.mapsHandling.handleButtonPress(text: "teleportMenu_Island")
            break
        case "subMenu_Op1":
            //Submenu button pressed
            scene.menuHandling.handleButtonPress(text: "subMenu_Op1")
            break
        case "subMenu_Op2":
            //Submenu button pressed
            scene.menuHandling.handleButtonPress(text: "subMenu_Op2")
            break
        case "subMenu_Op3":
            //Submenu button pressed
            scene.menuHandling.handleButtonPress(text: "subMenu_Op3")
            break
        case "submenuBackground":
            break
        default:
            scene.uiHandling.subMenu.isHidden = true
            scene.uiHandling.teleportMenu.isHidden = true
            break
        }
    }
}

struct elementsZPos {
    static let expCircleRange: CGFloat = -3
    static let expCircle: CGFloat = -2
    static let monsterDestroyedEffect: CGFloat = -2
    static let goldDrops: CGFloat = -1
    static let player: CGFloat = 0
    static let monsters: CGFloat = 0
    static let monstersHealthbarZPos: CGFloat = 1
    static let monstersHealthbarFGZPos: CGFloat = 2
    static let monstersKilledLabel: CGFloat = 10
    static let goldLabel: CGFloat = 10
    static let submenu: CGFloat = 11
    static let menuButton: CGFloat = 11
    static let submenuButton: CGFloat = 12
}

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let monster: UInt32 = 0b1  // 1
    static let player: UInt32 = 0b10 // 2
}
