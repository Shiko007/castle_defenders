//
//  MonsterConfig.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 05.10.24.
//

import SpriteKit

public class MonsterConfig {
    //Monster Config
    let monsterAnimationSpeed : CGFloat = 0.15
    let monsterWidth : CGFloat = 50
    let monsterHeight : CGFloat = 50
    let monsterMovmentSpeed : CGFloat = 50.0
    let monsterSpawnSpeed : CGFloat = 0.5
    let monsterMaxHealth : Int = 50
    let monsterExpWorth : Int = 1
    
    //Health Bar Config
    let healthbarDistanceFromMonster : CGFloat = 20
    let healthbarFGColor : UIColor = .red
    let healthbarBGColor : UIColor = .lightGray
    
    //Killed Monsters Counter Config
    let killedMonsCounterLabel : String = "0"
    let killedMonsLabelFont : String = "Avenir-Light"
    let killedMonsLabelFontSize : CGFloat = 30
    let killedMonsLabelColor : UIColor = .red
}
