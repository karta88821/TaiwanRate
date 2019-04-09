//
//  ImmediateRateSection.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/30.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import UIKit

protocol ImmediateRateSectionDelegate {
    func changedExchangedRate()
}

class ImmediateRateSection: BaseCell {
    
    var type: RateSectionType? {
        didSet {
            updateUI()
        }
    }
    
    var exchangeRate: ExchangeRate? {
        didSet {
            guard let exchangeRate = exchangeRate else { return }
            titleLabel.text = exchangeRate.title
        }
    }
    
    var delegate: ImmediateRateSectionDelegate?
    
    fileprivate func updateUI() {
        guard let type = type else { return }
        switch type {
        case .todayRate:
            titleLabel.text = type.title
            button.setImage(UIImage(named: "rate-changed")?.withRenderingMode(.alwaysOriginal), for: .normal)
        case .topFiveRate:
            titleLabel.text = type.title
            button.setTitle("更多", for: .normal)
            button.setTitleColor(.black, for: .normal)
        }
    }
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 245, g: 242, b: 249)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    @objc func handleButton() {
        guard let type = type else { return }
        switch type {
        case .todayRate:
            delegate?.changedExchangedRate()
        case .topFiveRate:
            print("topFiveRate")
        }
    }
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor(r: 92, g: 89, b: 94)
        
        addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 25)
        titleLabel.anchorCenterSuperview()
        
        addSubview(button)
        button.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 60, height: 0)
    }
    
}
