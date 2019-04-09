//
//  RateDisplayCell.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/30.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import UIKit

class RateDisplayCell: BaseCell {
    
    var currency: Currency? {
        didSet {
            guard let currency = currency else { return }
            buyView.currency = currency
            sellView.currency = currency
        }
    }
    
    
    
    let buyView = SingleRateView()
    
    let sellView: SingleRateView = {
        let rateView = SingleRateView()
        rateView.transactionStatus = .sell
        return rateView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        let rateStackView = setupRateStackView()
        addSubview(rateStackView)
        rateStackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        let timeView = setupTimeView()
        addSubview(timeView)
        timeView.anchor(top: rateStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 1, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setupRateStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [buyView, sellView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        return stackView
    }
    
    func setupTimeView() -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .defaultBackground()
        
        containerView.addSubview(timeLabel)
        timeLabel.anchor(top: nil, left: nil, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 300, height: 25)
        timeLabel.anchorCenterYToSuperview()
        
        return containerView
    }
}
