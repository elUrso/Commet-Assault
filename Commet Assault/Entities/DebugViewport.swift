//
//  DebugViewport.swift
//  Commet Assault
//
//  Created by Vitor Silva on 19/03/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//

import SpriteKit

class DebugViewport: SKLabelNode {
    override init() {
        super.init()
        self.verticalAlignmentMode = .top
        self.horizontalAlignmentMode = .left
        self.fontName = "Monaco"
        self.fontSize = 12
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
