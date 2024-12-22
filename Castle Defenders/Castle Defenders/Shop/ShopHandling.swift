//
//  ShopHandling.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 22.12.24.
//

import SpriteKit

public class ShopHandling {
    var shop : Shop!
    func createMenuShop(view : SKView, scene : GameScene) -> SKNode {
        shop = Shop(player: scene.player)
        var shopItemsList : [(String, String)] = [("", "")]
        shopItemsList = [("Speed", "shop_AttackSpeed")]
        shopItemsList.append(("Damage" , "shop_AttackDamage"))
        
        let shopMenu = scene.common.createSubmenu(view: view, scene: scene, buttons: shopItemsList)
        
        return shopMenu
    }
    func handleButtonPress(text : String, scene : GameScene){
        switch text {
        case "shop_AttackSpeed":
            if(shop.purchase(player: scene.player, itemIndex: 0, playerGold: &scene.player.gold)){
                print("Attack Speed Purchase Successful")
            }else{
                print("Attack Speed Purchase Unuccessful")
            }
            break
        case "shop_AttackDamage":
            if(shop.purchase(player: scene.player, itemIndex: 1, playerGold: &scene.player.gold)){
                print("Attack Damage Purchase Successful")
            }else{
                print("Attack Damage Purchase Unuccessful")
            }
            break
        default:
            print("Unknown option selected")
        }
    }
}
