//
//  SingleRateView.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/30.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import UIKit

class SingleRateView: UIView {
    
    var currency: Currency? {
        didSet {
            guard let currency = currency else { return }
            switch currency.exchangeRate {
            case .cash:
                switch transactionStatus {
                case .buy:
                    rateLabel.text = currency.cashExchangeRate.buy
                case .sell:
                    rateLabel.text = currency.cashExchangeRate.sell
                }
            case .check:
                switch transactionStatus {
                case .buy:
                    rateLabel.text = currency.checkExchangeRate.buy
                case .sell:
                    rateLabel.text = currency.checkExchangeRate.sell
                }
            }

        }
    }

    
    func dailyPircing(currValue: Double, yesValue: Double) -> Double {
        return ((currValue - yesValue) / yesValue).roundValue
    }

    var transactionStatus: TransactionStatus = .buy {
        didSet {
            updateUI()
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.buyRate()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let dailyPricingLabel: UILabel = {
        let label = UILabel()
        label.text = "-0.01"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .fallColor()
        return label
    }()
    
    let changeRangeLabel: UILabel = {
        let label = UILabel()
        label.text = "-0.03%"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .fallColor()
        return label
    }()
    
    fileprivate func updateUI() {
        titleLabel.text = transactionStatus.title
        rateLabel.textColor = transactionStatus.rateTextcolor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(r: 58, g: 54, b: 59)
        
        addSubview(rateLabel)
        rateLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        rateLabel.anchorCenterSuperview()
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 30)
        titleLabel.anchorCenterXToSuperview()
        
        addSubview(dailyPricingLabel)
        dailyPricingLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 4, paddingRight: 0, width: 60, height: 30)
        
        addSubview(changeRangeLabel)
        changeRangeLabel.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 4, paddingRight: 4, width: 60, height: 30)
        
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
