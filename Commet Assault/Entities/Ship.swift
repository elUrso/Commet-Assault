//
//  Ship.swift
//  Commet Assault
//
//  Created by Vitor Silva on 19/03/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//

import SpriteKit

class Ship: SKNode {
    var state: State
    
    struct State {
        var rotationState: RotationState = .still
        var accelerationState: AccelerationState = .still
        var speed: Double = 0
        var rotationSpeed: Double = 2
        var angle: Double = 0
        var acceleration: Double = 300
        var maxVelocity: Double = 500
        var drag: Double = 0.3
    }
    
    enum RotationState {
        case right, still, left
    }
    
    enum AccelerationState {
        case foward, still, backwards
    }
    
    var sprite: SKSpriteNode!
    
    override init() {
        self.state = State()
        super.init()
        self.sprite = SKSpriteNode(imageNamed: "Ship")
        self.sprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.sprite.zPosition = 200
        self.addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Static value
    var shadowElapsed: TimeInterval = 0
    func shadow(deltaTime: TimeInterval) {
        shadowElapsed += deltaTime
        if shadowElapsed > abs(1/sqrt(state.speed)) {
            shadowElapsed = 0
            let shadow = SKSpriteNode(imageNamed: "Ship")
            shadow.position = self.sprite.position
            shadow.zPosition = 100
            shadow.run(.rotate(toAngle: CGFloat(state.angle), duration: 0))
            self.addChild(shadow)
            shadow.run(.sequence([
                .fadeOut(withDuration: state.speed/500),
                .removeFromParent()
            ]))
        }
    }
    
    func update(deltaTime: TimeInterval) {
        switch state.rotationState {
        case .right:
            state.angle -= state.rotationSpeed * deltaTime
        case .left:
            state.angle += state.rotationSpeed * deltaTime
        default: break
        }
        
        switch state.accelerationState {
        case .foward:
            state.speed = min(state.maxVelocity, state.speed + state.acceleration * deltaTime)
        case .backwards:
            state.speed = max(-state.maxVelocity, state.speed - state.acceleration * deltaTime)
        default:
            state.speed = state.speed * (1 - state.drag * deltaTime)
            if abs(state.speed) < 0.1 { state.speed = 0 }
        }
        
        // Update Rotation
        self.sprite!.run(SKAction.rotate(toAngle: CGFloat(state.angle), duration: 0))
        
        // Update Position
        sprite.position.x += CGFloat(state.speed * deltaTime * state.angle.as2DVector.x)
        sprite.position.y += CGFloat(state.speed * deltaTime * state.angle.as2DVector.y)
        
        shadow(deltaTime: deltaTime)
    }
}

extension Double {
    var as2DVector: vector_double2{
        return vector2(-sin(self), cos(self))
    }
}
