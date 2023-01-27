//
//  PlayerNode.swift
//  Jumpgame
//
//  Created by Yura Mezhik on 23.01.2023.
//

import SpriteKit

class PlayerNode: SKNode{
    
    //MARK: - Properties
    private var player: SKShapeNode!
    private var diff = 0
    private let radius: CGFloat = 30.0
    
    
    
    //MARK: - Initializes
    init(diff: Int) {
        super.init()
        self.diff = diff
        
        self.name = "Player"
        self.zPosition = 10.0
        
        self.setupPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: - Setups
extension PlayerNode {
    
    private func setupPhysics(){
        player = SKShapeNode(circleOfRadius: radius)
        player.name = "Player"
        player.zPosition = .pi
        player.fillColor = UIColor(hex: 0xFF43FC )
        player.physicsBody = SKPhysicsBody(circleOfRadius: radius*0.8)
        player.physicsBody?.isDynamic = false
        player.physicsBody?.linearDamping = 0.0
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.usesPreciseCollisionDetection = true
        player.physicsBody?.restitution = 0.0
        player.physicsBody?.friction = 1.0
        player.physicsBody?.mass = 10.0
        player.physicsBody?.categoryBitMask = PhysicsCategories.Player
        player.physicsBody?.contactTestBitMask = PhysicsCategories.Wall | PhysicsCategories.Side | PhysicsCategories.Obstacles | PhysicsCategories.Score
        player.physicsBody?.collisionBitMask = PhysicsCategories.Side
        addChild(player)
    }
    
    internal func activate(_ isDynamic: Bool){
        player.physicsBody?.isDynamic = isDynamic
    }
    internal func jump(_ right: Bool){
        let velocity = CGVector(dx: right ? -200 : 200 , dy: 1000)
        
        player.physicsBody?.velocity = velocity
    }
    
    internal func over(){
        player.fillColor = .red
        activate(false)
    }
    internal func side(){
        player.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 50.0))
    }
    
    internal func height() -> CGFloat {
         return player.position.y + screenHeight/2 * 0.75
    }
}
