//
//  GameController.swift
//  Commet Assault
//
//  Created by Vitor Silva on 19/03/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//

import SpriteKit

class GameController {
    var scene: GameScene
    var deltaTime: TimeInterval = 0
    var lastTime: TimeInterval = 0
    var currentTime: TimeInterval = 0
    
    var joystick: Joystick!
    
    init(size: CGSize) {
        self.scene = GameScene(size: size)
        self.scene.controller = self

        self.joystick = Joystick()
        self.joystick.controller = self
    }
    
    func update(currentTime: TimeInterval) {
        deltaTime = min(currentTime-lastTime, 0.5)
        self.currentTime = currentTime
        defer { lastTime = currentTime }
        
        updateDebug()
        
        scene.ship.update(deltaTime: deltaTime)
    }
    
    func updateDebug() {
        scene.debug.text = """
            currentTime: \(currentTime.round(3))
            deltaTime: \(deltaTime.round(3))
            FPS: \(deltaTime.inverse.round(3))
        """
    }
    
    func hanlde(input: Input) {
        switch input {
        case .dpad(let x , let y):
            if x == 0 {
                scene.ship.state.rotationState = .still
            } else if x > 0 {
                scene.ship.state.rotationState = .right
            } else {
                scene.ship.state.rotationState = .left
            }
            
            if y == 0 {
                scene.ship.state.accelerationState = .still
            } else if y > 0 {
                scene.ship.state.accelerationState = .foward
            } else {
                scene.ship.state.accelerationState = .backwards
            }
        }
    }
    
    enum Input {
        case dpad(x: Float, y: Float)
    }
}

extension Double {
    var inverse: Double { 1/self }
    func round(_ decimalPlaces: Int) -> String {
        String(format: "%0.\(decimalPlaces)lf", self)
    }
}
