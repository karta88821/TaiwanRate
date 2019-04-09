//
//  Flag.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/11/1.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import Foundation

enum Flag: String {
    case USD = "USD"
    case CAD = "CAD"
    case EUR = "EUR"
    case GBP = "GBP"
    case SEK = "SEK"
    case CHF = "CHF"
    case AUD = "AUD"
    case NZD = "NZD"
    case CNY = "CNY"
    case JPY = "JPY"
    case HKD = "HKD"
    case SGD = "SGD"
    case MYR = "MYR"
    case KRW = "KRW"
    case THB = "THB"
    case PHP = "PHP"
    case ZAR = "ZAR"
    case IDR = "IDR"
    case VND = "VND"
}

extension Flag {
    var imageUrlString: String {
        let baseUrl = "https://cdn1.iconfinder.com/data/icons/ensign-11/512"
        switch self {
        case .USD:
            return baseUrl + "/274_Ensign_Flag_Nation_states-128.png"
        case .CAD:
            return baseUrl + "/49_Ensign_Flag_Nation_canada-128.png"
        case .EUR:
            return baseUrl + "/82_Ensign_Flag_Nation_union-128.png"
        case .GBP:
            return baseUrl + "/273_Ensign_Flag_Nation_kingdom-128.png"
        case .SEK:
            return baseUrl + "/247_Ensign_Flag_Nation_sweden-128.png"
        case .CHF:
            return baseUrl + "/248_Ensign_Flag_Nation_switzerland-128.png"
        case .AUD:
            return baseUrl + "/19_Ensign_Flag_Nation_Australia-128.png"
        case .NZD:
            return baseUrl + "/185_Ensign_Flag_Nation_new_zealand-128.png"
        case .CNY:
            return baseUrl + "/57_Ensign_Flag_Nation_china-128.png"
        case .JPY:
            return baseUrl + "/127_Ensign_Flag_Nation_japan-128.png"
        case .HKD:
            return baseUrl + "/113_Ensign_Flag_Nation_hongkong-128.png"
        case .SGD:
            return baseUrl + "/232_Ensign_Flag_Nation_singapore-128.png"
        case .MYR:
            return baseUrl + "/160_Ensign_Flag_Nation_malaysia-128.png"
        case .KRW:
            return baseUrl + "/141_Ensign_Flag_Nation_south-128.png"
        case .THB:
            return baseUrl + "/254_Ensign_Flag_Nation_thailand-128.png"
        case .PHP:
            return baseUrl + "/202_Ensign_Flag_Nation_philippines-128.png"
        case .ZAR:
            return baseUrl + "/238_Ensign_Flag_Nation_south-128.png"
        case .IDR:
            return baseUrl + "/117_Ensign_Flag_Nation_indonesia-128.png"
        case .VND:
            return baseUrl + "/280_Ensign_Flag_Nation_vietnam-128.png"
        }
    }
}

