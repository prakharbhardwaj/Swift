//
//  Game.swift
//  SpriteKit
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import SpriteKit

class Game: SKScene, SKPhysicsContactDelegate {
    
    let score = SKLabelNode(fontNamed:"Chalkduster")
    var points = 0
    enum ColliderType: UInt32 {
        case player = 1
        case target = 2
    }
    var target:SKSpriteNode!
    var value:Float = 0.0
    @IBAction func manejarSlider(_ sender:UISlider){
        value = sender.value
    }
    
    override func didMove(to view: SKView) {
        
        //define physics
        self.physicsWorld.contactDelegate = self
        let size2 = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom:size2)
        
        //define the player
        let player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: 200,y: 25)
        player.name = "Player"
        player.physicsBody?.categoryBitMask = ColliderType.player.rawValue
        player.physicsBody?.collisionBitMask = ColliderType.target.rawValue
        player.physicsBody?.contactTestBitMask = ColliderType.target.rawValue
        self.addChild(player)
        
        //define target
        target = SKSpriteNode(color: UIColor.green, size: CGSize(width: 20, height: 20))
        target.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        target.physicsBody?.isDynamic = false
        target.position = CGPoint(x: 200, y: 530)
        target.name = "Target"
        target.physicsBody?.categoryBitMask = ColliderType.target.rawValue
        target.physicsBody?.collisionBitMask = ColliderType.player.rawValue
        target.physicsBody?.contactTestBitMask = ColliderType.player.rawValue
        self.addChild(target)
        
        //to move
        let move = SKAction.sequence([SKAction.move(to: CGPoint(x: 0, y: 530), duration: 2.0),SKAction.move(to: CGPoint(x: 320, y: 530), duration: 2.0)])
        let moveConstant = SKAction.repeatForever(move)
        target.run(moveConstant)
        
        //actual score
        score.text = "Score: \(points)";
        score.name = "Points"
        score.fontSize = 15;
        score.position = CGPoint(x:self.frame.midX, y:self.frame.midY);
        self.addChild(score)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //on touch shoot
        var operation:CGFloat = 250.0
        operation *= (CGFloat)(self.value)
        self.childNode(withName: "Player")?.physicsBody?.applyForce(CGVector (dx: operation, dy: 20000))
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        //if bodys impact
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if(firstBody.categoryBitMask == 1 && secondBody.categoryBitMask == 2){
            //if impact:
            //update score (delete and add label)
            points += 1
            self.childNode(withName: "Points")?.removeFromParent()
            score.text = "Score: \(points)"
            self.addChild(score)
            //delete object
            secondBody.node?.removeFromParent()
            //wait a second and show object
            let delay = SKAction.wait(forDuration: 1)
            let generar = SKAction.run({
                self.addChild(self.target)
            })
            let secuency = SKAction.sequence([delay,generar])
            self.run(secuency)
        }
    }
    
}
