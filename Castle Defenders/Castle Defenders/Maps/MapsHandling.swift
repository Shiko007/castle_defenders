//
//  MapsHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 15.12.24.
//

import SpriteKit


public class MapsHandling {
    let common = Common()
    func CreateMapsSubmenu(view : SKView, scene : SKScene) -> SKNode {
        var mapsButtonsList : [(String, String)] = [("", "")]
        mapsButtonsList = [("Mine", "teleportMenu_Mine")]
        mapsButtonsList.append(("City" , "teleportMenu_City"))
        mapsButtonsList.append(("Island" , "teleportMenu_Island"))
        let mapsSubmenu = common.createSubmenu(view: view, scene: scene, buttons: mapsButtonsList)
        
        return mapsSubmenu
    }
    
    func handleButtonPress(text : String){
        switch text {
        case "teleportMenu_Mine":
            print("Mine selected")
        case "teleportMenu_City":
            print("City selected")
        case "teleportMenu_Island":
            print("Island selected")
        default:
            print("Unknown option selected")
        }
    }
}
