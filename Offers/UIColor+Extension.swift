//
//  UIColor+Extension.swift
//  Offers
//
//  Created by Alex Paul on 6/13/23.
//

import UIKit


extension UIColor {
    convenience init(name: String) {
        let scanner = Scanner(string: name)
        scanner.currentIndex = name.hasPrefix("#") ? name.index(after: name.startIndex) : name.startIndex
        
        var colorValue: UInt64 = 0
        scanner.scanHexInt64(&colorValue)
        
        let r = CGFloat((colorValue & 0xff0000) >> 16) / 255.0
        let g = CGFloat((colorValue & 0x00ff00) >> 8) / 255.0
        let b = CGFloat(colorValue & 0x0000ff) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
