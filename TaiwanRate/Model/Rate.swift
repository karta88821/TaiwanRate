//
//  Rate.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/11/6.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import Foundation

struct Rate {
    let buy: String
    let sell: String
}

extension Rate {
    var isEmpty: Bool {
        return buy == "-" && sell == "-"
    }
}
