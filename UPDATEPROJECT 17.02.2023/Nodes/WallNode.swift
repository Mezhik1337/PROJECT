//
//  WallNode.swift
//  Jumpgame
//
//  Created by Yura Mezhik on 25.01.2023.
//

import SpriteKit

class WallNode: SKNode{
    
    //MARK: - Properties
    private var node: SKSpriteNode!
    private var diff = 0
    private let radius: CGFloat = 30.0
    
    
    
    //MARK: - Initializes
    override init(){
        super.init()
        self.name = "Wall"
        self.zPosition = 5.0
            
        self.setupPhysics()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: - Setups
extension WallNode {
    
    private func setupPhysics(){
        let size = CGSize(width: screenWidth, height: 40.0)
        node = SKSpriteNode(color: .clear, size: size)
        node.physicsBody = SKPhysicsBody(rectangleOf: size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.restitution = 1.0
        node.physicsBody?.mass = 100.0
        node.physicsBody?.categoryBitMask = PhysicsCategories.Wall
        node.physicsBody?.collisionBitMask = PhysicsCategories.Player
        
        addChild(node)
    }
}
