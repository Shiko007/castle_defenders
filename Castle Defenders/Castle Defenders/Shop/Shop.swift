//
//  Shop.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 22.12.24.
//
import SpriteKit

struct ShopItem {
    var name: String
    var level: Int
    var basePrice: Int
    var effect: (PlayerNode) -> Void

    func currentPrice() -> Int {
        return basePrice * (level + 1)
    }
}

class Shop {
    var items: [ShopItem] = []

    init(player: PlayerNode) {
        items = [
            ShopItem(
                name: "Attack Speed",
                level: 0,
                basePrice: 50,
                effect: { player in
                    player.attackCooldown *= 0.9 // Increases attack speed by 10%
                }
            ),
            ShopItem(
                name: "Attack Damage",
                level: 0,
                basePrice: 100,
                effect: { player in
                    player.attackDamage += 10 // Increases attack damage
                }
            )
        ]
    }

    func purchase(player: PlayerNode, itemIndex: Int, playerGold: inout Int) -> Bool {
        let item = items[itemIndex]
        let price = item.currentPrice()

        if playerGold >= price {
            playerGold -= price
            items[itemIndex].level += 1
            items[itemIndex].effect(player) // Apply the effect
            return true
        }

        return false
    }
}
