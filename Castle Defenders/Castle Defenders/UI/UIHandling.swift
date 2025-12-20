//
//  UIHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 16.12.24.
//

import SpriteKit

class UIHandling {
    var killedCounterLabel : SKLabelNode!
    var goldCounterLabel : SKLabelNode!
    var subMenu: SKNode!
    var teleportMenu: SKNode!
    var shopMenu: SKNode!
    
    func showUI(scene : GameScene, view : SKView) {
        // Create menu buttons with better SF Symbol icons - BIGGER SIZE
        let menuButton = scene.common.createIconButton(
            iconName: "line.3.horizontal.circle.fill",  // Hamburger menu icon
            name: "menuButton", 
            size: CGSize(width: 80, height: 80),  // Increased from 60
            position: scene.convertPoint(fromView: CGPoint(x: view.bounds.minX + 50, y: view.bounds.minY + 50))
        )
        
        let teleportButton = scene.common.createIconButton(
            iconName: "location.circle.fill",  // Location/map icon
            name: "teleportButton", 
            size: CGSize(width: 80, height: 80),  // Increased from 60
            position: scene.convertPoint(fromView: CGPoint(x: view.bounds.maxX - 50, y: view.bounds.minY + 50))
        )
        
        teleportMenu = scene.mapsHandling.CreateMapsSubmenu(view: view, scene: scene)
        subMenu = scene.menuHandling.createMenuSubmenu(view: view, scene: scene)
        shopMenu = scene.shopHandling.createMenuShop(view: view, scene: scene)
        killedCounterLabel = scene.monsterHandling.createKilledMonstersLabel(view : view, scene : scene)
        goldCounterLabel = scene.goldHandling.createGoldLabel(view : view, scene : scene)
        teleportMenu.isHidden = true
        subMenu.isHidden = true
        shopMenu.isHidden = true
        
        scene.addChild(killedCounterLabel)
        scene.addChild(goldCounterLabel)
        scene.addChild(teleportMenu)
        scene.addChild(subMenu)
        scene.addChild(shopMenu)
        scene.addChild(menuButton)
        scene.addChild(teleportButton)
    }
    
    func toggleHidden(node : SKNode) {
        // Show or hide the submenu
        node.isHidden = !node.isHidden
    }
}
