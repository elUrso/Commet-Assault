//
//  Joysticks.swift
//  Commet Assault
//
//  Created by Vitor Silva on 19/03/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//

import GameController

class Joystick {
    var controller: GameController!
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateControllers), name:
            .GCControllerDidConnect, object: nil)
    }
    
    func dpad(pad: GCControllerDirectionPad, x: Float, y: Float) {
        print("dpad(\(x), \(y))")
        controller.hanlde(input: .dpad(x: x, y: y))
    }
    
    func action(button: GCControllerButtonInput, pressure: Float, pressed: Bool) {
        print("\(button)(\(pressed), \(pressure))")
    }
    
    @objc func updateControllers() {
        for controller in GCController.controllers() {
            if let extendedGamepad = controller.extendedGamepad {
                extendedGamepad.dpad.valueChangedHandler = dpad
                extendedGamepad.buttonA.valueChangedHandler = action
            }
        }
    }
}
