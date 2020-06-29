//
//  GameScene.swift
//  Commet Assault
//
//  Created by Vitor Silva on 19/03/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var controller: GameController!
    var debug: DebugViewport!
    var ship: Ship!
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = .black
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.ship = Ship()
        self.ship.position = CGPoint(x: 0, y: -200)
        self.addChild(ship)
        
        self.debug = DebugViewport()
        debug.position = CGPoint(x: -size.width / 2, y: size.height / 2)
        self.addChild(debug)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        controller.update(currentTime: currentTime)
    }
}
