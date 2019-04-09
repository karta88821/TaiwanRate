//
//  String+format.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/11/2.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double {
        return Double(self) ?? 0.00
    }
    
    func withoutSpacing() -> String {
        return self.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
    }
    
    var sepElements: [Character] {
        return self.map{$0}
    }
    
    var withoutParentheses: String {
        var components = self.components(separatedBy: "(")
        if components.count > 1 {
            components.removeLast()
            return components.joined(separator: "(")
        } else {
            return self
        }
    }
}
