//
//  Currency.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/31.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import Foundation

struct Currency {
    var exchangeRate: ExchangeRate
    var date: String?
    let countryName: String
    let cashExchangeRate: Rate
    let checkExchangeRate: Rate
}

extension Currency {
    var shortDateString: String {
        return String(date?.suffix(5) ?? "")
    }
    
    func currentRate() -> Rate {
        switch exchangeRate {
        case .cash:
            return cashExchangeRate
        case .check:
            return checkExchangeRate
        }
    }
}

extension Currency {
    var flag: Flag {
        switch countryName {
        case "美金":
            return .USD
        case "加拿大幣":
            return .CAD
        case "歐元":
            return .EUR
        case "英鎊":
            return .GBP
        case "瑞典幣":
            return .SEK
        case "瑞士法郎":
            return .CHF
        case "澳幣":
            return .AUD
        case "紐幣", "紐元":
            return .NZD
        case "人民幣":
            return .CNY
        case "日幣", "日圓":
            return .JPY
        case "港幣":
            return .HKD
        case "新加坡幣":
            return .SGD
        case "馬來幣":
            return .MYR
        case "韓元":
            return .KRW
        case "泰銖", "泰幣":
            return .THB
        case "菲律賓比索", "菲國比索":
            return .PHP
        case "南非幣":
            return .ZAR
        case "印尼盾", "印尼幣":
            return .IDR
        case "越南盾":
            return .VND
        default:
            return .USD
        }
    }
}

