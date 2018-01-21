//
//  GameScene.swift
//  Etch
//
//  Created by Wes Ong on 2018-01-20.
//  Copyright © 2018 Wes Ong. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    static var clearDrawing: Bool = false
    static var leftValid: Bool = true
    static var rightValid: Bool = true
    
    var drawPath = CGMutablePath.init()
    var lastPosition: CGPoint = CGPoint(x: 0, y: 0)
    static var newPosition: CGPoint = CGPoint(x: 0, y: 0)
    
    
    static var sensitivity: CGFloat = 2
    
    override func didMove(to view: SKView) {
        drawPath.move(to: lastPosition)
    }
    
    override func update(_ currentTime: TimeInterval) {
        GameScene.newPosition.x.clamp(v1: -550,550)
        GameScene.newPosition.y.clamp(v1: -143,375)
        
        if GameScene.clearDrawing {
            GameScene.clearDrawing = false
            drawPath = CGMutablePath.init()
            drawPath.move(to: lastPosition)
            enumerateChildNodes(withName: "line", using: {node, stop in
                node.removeFromParent()
            })
        }
      
        if !GameScene.leftValid || !GameScene.rightValid {
            GameScene.newPosition = lastPosition
        }
        else if GameScene.newPosition != lastPosition{
            
            enumerateChildNodes(withName: "line", using: {node, stop in
                node.removeFromParent()
            })
            
            lastPosition = GameScene.newPosition
            drawPath.addLine(to: GameScene.newPosition)
            let shapeNode = SKShapeNode()
            shapeNode.path = drawPath
            shapeNode.name = "line"
            shapeNode.strokeColor = UIColor.gray
            shapeNode.lineWidth = 5
            shapeNode.zPosition = 5
            self.addChild(shapeNode)
        }
    }
}
