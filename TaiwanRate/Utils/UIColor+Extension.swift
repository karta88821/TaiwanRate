//
//  UIColor+Extension.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/30.
//  Copyright © 2018 liao yuhao. All rights reserved.
//
import UIKit

extension UIColor {
    
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(r: r, g: g, b: b, a: 1)
    }
    
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    static func buyRate() -> UIColor {
        return UIColor(r: 54, g: 126, b: 247)
    }
    
    static func sellRate() -> UIColor {
        return UIColor(r: 240, g: 151, b: 66)
    }
    
    static func defaultBackground() -> UIColor {
        return UIColor(r: 58, g: 54, b: 59)
    }
    
    static func riseColor() -> UIColor {
        return UIColor(r: 235, g: 68, b: 58)
    }
    
    static func fallColor() -> UIColor {
        return UIColor(r: 162, g: 232, b: 72)
    }
    // background -> 58 54 59
    // navigation bar -> 43 39 44
    // header -> 92 89 94
    // buyRate -> 90 158 240
    // sellRate -> 238 167 57
}
