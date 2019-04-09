//
//  TransactionStatus.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/11/2.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import UIKit

enum TransactionStatus: String {
    case buy = "銀行買入價"
    case sell = "銀行賣出價"
}

extension TransactionStatus {
    
    var title: String {
        switch self {
        case .buy:
            return rawValue
        case .sell:
            return rawValue
        }
    }
    
    var rateTextcolor: UIColor {
        switch self {
        case .buy:
            return .buyRate()
        case .sell:
            return .sellRate()
        }
    }
}
