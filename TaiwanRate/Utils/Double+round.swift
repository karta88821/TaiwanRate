//
//  Double+round.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/11/2.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import Foundation

extension Double {
    var roundValue: Double {
        return (self * 1000).rounded() / 1000
    }
}
