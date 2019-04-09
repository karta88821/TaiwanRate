//
//  ImmediateRateHeader.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/30.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import UIKit

class ImmediateRateHeader: BaseCell {
    
    let rateSelectedSegmentedControl: UISegmentedControl = {
        let seg = UISegmentedControl(items: ["All", "現金", "即期"])
        seg.tintColor = .white
        seg.selectedSegmentIndex = 0
        return seg
    }()
    
    override func setupViews() {
        addSubview(rateSelectedSegmentedControl)
        rateSelectedSegmentedControl.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 48, paddingBottom: 16, paddingRight: 48, width: 0, height: 0)
    }
}
