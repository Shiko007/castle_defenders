//
//  MainMenuScene.swift
//  Castle Defenders
//
//  Created by Sherif Yasser on 17.10.24.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        let common = Common()
        // Create the "Start" button
        let startButton = common.createButton(withText: "Start",name: "startNode", size: CGSize(width: self.size.width / 1.5, height: self.size.width / 10), position: CGPoint(x: frame.midX, y: frame.midY))
        self.backgroundColor = .white
        addChild(startButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Detect touch on the start button
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            if touchedNode.name == "startNode" {
                // Transition to the GameScene
                let gameScene = GameScene(size: self.size)
                gameScene.anchorPoint = self.anchorPoint
                gameScene.scaleMode = .aspectFill
                let transition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}
