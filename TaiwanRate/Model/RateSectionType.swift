//
//  RateSectionType.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/31.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import Foundation

protocol RateSectionTypeRequirement {
    var title: String? { get }
}

enum RateSectionType {
    case todayRate
    case topFiveRate
}

extension RateSectionType: RateSectionTypeRequirement {
    var title: String? {
        switch self {
        case .todayRate:
            return "現金匯率"
        case .topFiveRate:
            return "近五個交易日"
        }
    }
}
