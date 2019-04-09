//
//  RateInfoCell.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/30.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import UIKit

class RateInfoCell: BaseCell {
    
    var history: Currency? {
        didSet {
            guard let history = history else { return }
            dateLabel.text = history.shortDateString
        }
    }
    
    var exchangedRate: ExchangeRate? {
        didSet {
            guard let exchangedRate = exchangedRate else { return }
            guard let history = history else { return }
            
            switch exchangedRate {
            case .cash:
                buyPriceLabel.text = history.cashExchangeRate.buy
                sellPriceLabel.text = history.cashExchangeRate.sell
            case .check:
                buyPriceLabel.text = history.checkExchangeRate.buy
                sellPriceLabel.text = history.checkExchangeRate.sell
            }
        }
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let buyPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.buyRate()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let sellPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.sellRate()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    let mediumRiseLabel: UILabel = {
        let label = UILabel()
        label.text = "30.9150"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    let dailyPricingLabel: UILabel = {
        let label = UILabel()
        label.text = "▼-0.0050" // ▲
        label.textColor = UIColor.fallColor()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        let fieldStackView = setupFieldStackView()
        addSubview(fieldStackView)
        fieldStackView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
    
    func setupFieldStackView() -> UIStackView {
        let rightSideStackView = UIStackView(arrangedSubviews: [mediumRiseLabel, dailyPricingLabel])
        rightSideStackView.axis = .vertical
        rightSideStackView.distribution = .fillEqually
        let stackView = UIStackView(arrangedSubviews: [dateLabel, buyPriceLabel, sellPriceLabel, rightSideStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }
}
