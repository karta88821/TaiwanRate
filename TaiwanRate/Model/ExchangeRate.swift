//
//  ExchangeRate.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/31.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import Foundation

enum ExchangeRate: String {
    case cash = "cash"
    case check = "check"
}

extension ExchangeRate {
    
    var title: String {
        switch self {
        case .cash:
            return "現金匯率"
        case .check:
            return "即期匯率"
        }
    }
    
    mutating func reverse() {
        switch self {
        case .cash:
            self = .check
        case .check:
            self = .cash
        }
    }
}
