//
//  Dial.swift
//  Etch
//
//  Created by Wes Ong on 2018-01-20.
//  Copyright © 2018 Wes Ong. All rights reserved.
//

import Foundation
import GameplayKit

class LeftDial: SKSpriteNode {
    
    var oldPosition: CGPoint!
    var newPosition: CGPoint!
    
    var midpoint: CGPoint = CGPoint(x: 21, y: 53)
    var midIndicator: SKShapeNode!
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        midIndicator = SKShapeNode(rectOf: CGSize(width: 1, height: 2))
        midIndicator.position = midpoint
        midIndicator.fillColor = UIColor.black
        midIndicator.zPosition = 5
        self.addChild(midIndicator)
        
        self.isUserInteractionEnabled = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        oldPosition = touches.first!.location(in: self)
        GameScene.leftValid = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        newPosition = touches.first!.location(in: self)
        
        if newPosition != oldPosition {
            
            if oldPosition.x < midpoint.x { // Quadrant 3/4
                if newPosition.y > oldPosition.y {
                    GameScene.newPosition = CGPoint(x: GameScene.newPosition.x + GameScene.sensitivity, y: GameScene.newPosition.y)
                    GameScene.leftValid = true
                }
                else if newPosition.y < oldPosition.y { GameScene.newPosition = CGPoint(x: GameScene.newPosition.x - GameScene.sensitivity, y: GameScene.newPosition.y)
                    GameScene.leftValid = true
                }
                else {
                    GameScene.leftValid = false
                }
            }
            else if oldPosition.x > midpoint.x  { // Quadrant 1/2
                if newPosition.y < oldPosition.y {
                GameScene.newPosition = CGPoint(x: GameScene.newPosition.x + GameScene.sensitivity, y: GameScene.newPosition.y)
                    GameScene.leftValid = true
                }
                else if newPosition.y > oldPosition.y { GameScene.newPosition = CGPoint(x: GameScene.newPosition.x - GameScene.sensitivity, y: GameScene.newPosition.y)
                    GameScene.leftValid = true
                }
                else {
                    GameScene.leftValid = false
                }
            }
            else {
                GameScene.leftValid = false
            }
            oldPosition = newPosition
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        GameScene.leftValid = true
    }
}
