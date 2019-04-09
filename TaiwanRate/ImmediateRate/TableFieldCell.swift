//
//  TableFieldCell.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/30.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import UIKit

class TableFieldCell: BaseCell {
    
    let fields = ["日期", "銀行買入價", "銀行賣出價", "中漲/漲跌"]
    
    override func setupViews() {
        super.setupViews()
        let fieldStackView = setupFieldStackView()
        addSubview(fieldStackView)
        fieldStackView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
    
    func setupFieldStackView() -> UIStackView {
        let labels = fields.map { field -> UILabel in
            let label = UILabel()
            label.text = field
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }
        
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }
}
