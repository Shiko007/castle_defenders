//
//  MenuHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 15.12.24.
//

import SpriteKit


public class MenuHandling {
    let common = Common()
    let shopHandling = ShopHandling()
    func createMenuSubmenu(view : SKView, scene : SKScene) -> SKNode {
        var menuButtonsList : [(String, String)] = [("", "")]
        
        menuButtonsList = [("Shop", "subMenu_GoldShop")]
        //menuButtonsList.append(("Option 2" , "subMenu_Op2"))
        //menuButtonsList.append(("Option 3" , "subMenu_Op3"))
        
        let mapsSubmenu = common.createSubmenu(view: view, scene: scene, buttons: menuButtonsList)
        
        return mapsSubmenu
    }
    
    func handleButtonPress(text : String, scene : GameScene){
        switch text {
        case "subMenu_GoldShop":
            scene.uiHandling.subMenu.isHidden = true
            scene.uiHandling.teleportMenu.isHidden = true
            scene.uiHandling.toggleHidden(node: scene.uiHandling.shopMenu)
            break
        default:
            print("Unknown option selected")
        }
    }
}
