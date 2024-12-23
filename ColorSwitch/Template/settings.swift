//
//  settings.swift
//  ColorSwitch
//
//  Created by Anup Saud on 2024-12-23.
//

import SpriteKit

enum PhysicsCategories{
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1          // 01
    static let switchCategory: UInt32 = 0x1 << 1   // 10
}
