//
//  ViewController.swift
//  Commet Assault
//
//  Created by Vitor Silva on 19/03/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameController = GameController(size: self.view.frame.size)
        
        self.skView.presentScene(gameController.scene)
    }
}

