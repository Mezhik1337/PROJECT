//
//  GameViewController.swift
//  Jumpgame
//
//  Created by Yura Mezhik on 23.01.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        //print(PhysicsCategories.Player)
        //print(PhysicsCategories.Wall)
        //print(PhysicsCategories.Side)

        guard let view = self.view as? SKView else {
            return
        }
        
        let scene = EaseScene(size: CGSize(width: screenWidth, height: screenHeight))
        scene.scaleMode = .aspectFill
        
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        view.showsPhysics = false
        view.presentScene(scene)
    }
        
            

    

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
