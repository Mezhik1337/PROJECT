//
//  Types.swift
//  Jumpgame
//
//  Created by Yura Mezhik on 25.01.2023.
//

import UIKit

let screenWidth: CGFloat = 1536.0
let screenHeight: CGFloat = 2048.0

let appDl = UIApplication.shared.delegate as! AppDelegate



var playebleRect: CGRect{
    var ratio: CGFloat =  16/9
    
    if appDl.isIphoneX{
    ratio = 2.16
    } else if appDl.isIpad11{
        ratio = 1.43
    }
    
    let w: CGFloat = screenHeight / ratio
    let h: CGFloat = screenHeight
    let x: CGFloat = (screenWidth - w) / 2
    let y: CGFloat = 0.0
    
    return CGRect(x: x, y: y, width: w, height: h)

}

struct PhysicsCategories{
    static let Player:      UInt32 = 0b1
    static let Wall:        UInt32 = 0b10
    static let Side:        UInt32 = 0b100
    static let Obstacles:   UInt32 = 0b1000
    static let Score:       UInt32 = 0b10000
    static let SuperScore:  UInt32 = 0b100000



}

struct FontName{
    static let rimouski = "Rimouski"
    static let wheaton = "Wheaton"

}
