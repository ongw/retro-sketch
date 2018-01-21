//
//  RightDial.swift
//  Etch
//
//  Created by Wes Ong on 2018-01-20.
//  Copyright © 2018 Wes Ong. All rights reserved.
//

import Foundation
import GameplayKit

class RightDial: SKSpriteNode {
    
    var oldPosition: CGPoint!
    var newPosition: CGPoint!
    
    var midpoint: CGPoint = CGPoint(x: 79, y: 53)
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
        GameScene.rightValid = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        newPosition = touches.first!.location(in: self)
        
       if newPosition != oldPosition {
            if oldPosition.x < midpoint.x { // Quadrant 3/4
                if newPosition.y > oldPosition.y {
                GameScene.newPosition = CGPoint(x: GameScene.newPosition.x, y: GameScene.newPosition.y  + GameScene.sensitivity)
                    GameScene.rightValid = true
                }
                else if newPosition.y < oldPosition.y {
                GameScene.newPosition = CGPoint(x: GameScene.newPosition.x, y: GameScene.newPosition.y  - GameScene.sensitivity)
                    GameScene.rightValid = true
                }
                else {
                    GameScene.rightValid = false
                }
            }
            else if oldPosition.x > midpoint.x  { // Quadrant 1/2
                if newPosition.y < oldPosition.y {
                GameScene.newPosition = CGPoint(x: GameScene.newPosition.x, y: GameScene.newPosition.y + GameScene.sensitivity)
                    GameScene.rightValid = true
                }
                else if newPosition.y > oldPosition.y {
                GameScene.newPosition = CGPoint(x: GameScene.newPosition.x, y: GameScene.newPosition.y  - GameScene.sensitivity)
                    GameScene.rightValid = true
                }
                else {
                    GameScene.rightValid = true
                }
            }
            else {
                GameScene.rightValid = false
            }
            
            oldPosition = newPosition
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        GameScene.rightValid = true
    }
}
