//
//  MenuHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 15.12.24.
//

import SpriteKit


public class MenuHandling {
    let common = Common()
    func createMenuSubmenu(view : SKView, scene : SKScene) -> SKNode {
        var menuButtonsList : [(String, String)] = [("", "")]
        
        menuButtonsList = [("Option 1", "subMenu_Op1")]
        menuButtonsList.append(("Option 2" , "subMenu_Op2"))
        menuButtonsList.append(("Option 3" , "subMenu_Op3"))
        
        let mapsSubmenu = common.createSubmenu(view: view, scene: scene, buttons: menuButtonsList)
        
        return mapsSubmenu
    }
    
    func handleButtonPress(text : String){
        switch text {
        case "subMenu_Op1":
            print("Option 1 selected")
        case "subMenu_Op2":
            print("Option 2 selected")
        case "subMenu_Op3":
            print("Option 3 selected")
        default:
            print("Unknown option selected")
        }
    }
}
