//
//  UIHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 16.12.24.
//

import SpriteKit

class UIHandling {
    var killedCounterLabel : SKLabelNode!
    var subMenu: SKNode!
    var teleportMenu: SKNode!
    
    func showUI(scene : GameScene, view : SKView) {
        let menuButton = scene.common.createButton(withText: "I", name: "menuButton", size: CGSize(width: 50, height: 50), position: scene.convertPoint(fromView: CGPoint(x: view.bounds.minX + 50, y: view.bounds.minY + 50)))
        let teleportButton = scene.common.createButton(withText: "O", name: "teleportButton", size: CGSize(width: 50, height: 50), position: scene.convertPoint(fromView: CGPoint(x: view.bounds.maxX - 50, y: view.bounds.minY + 50)))
        
        teleportMenu = scene.mapsHandling.CreateMapsSubmenu(view: view, scene: scene)
        subMenu = scene.menuHandling.createMenuSubmenu(view: view, scene: scene)
        killedCounterLabel = scene.monsterHandler.createKilledMonstersLabel(view : view, scene : scene)
        
        teleportMenu.isHidden = true
        subMenu.isHidden = true
        
        scene.addChild(killedCounterLabel)
        scene.addChild(teleportMenu)
        scene.addChild(subMenu)
        scene.addChild(menuButton)
        scene.addChild(teleportButton)
    }
    
    func toggleHidden(node : SKNode) {
        // Show or hide the submenu
        node.isHidden = !node.isHidden
    }
}
