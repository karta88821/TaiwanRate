//
//  BankType.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/31.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import Foundation

protocol BankRequirement {
    var id: Int! { get }
    var swiftCode: String! { get }
}

enum BankType {
    case taiwan
    case land
    case cooperative
}

extension BankType: BankRequirement {
    var id: Int! {
        switch self {
        case .taiwan:           return 004
        case .land:             return 005
        case .cooperative:      return 006
        }
    }
    
    var swiftCode: String! {
        switch self {
        case .taiwan:           return "BKTWTWTP"
        case .land:             return "LBOTTWTP"
        case .cooperative:      return "TACBTWTP"
        }
    }

}
