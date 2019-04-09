//
//  CurrencyListCell.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/11/1.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import UIKit
import Kingfisher

class CurrencyListCell: BaseCell {
    
    var currency: Currency?
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let currencyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    func populate(with currency: Currency) {
        self.currency = currency
        
        guard let flagUrl = URL(string: currency.flag.imageUrlString) else { return }
        
        flagImageView.kf.setImage(with: flagUrl)
        currencyNameLabel.text = currency.countryName + " " + currency.flag.rawValue
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(flagImageView)
        flagImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 72, height: 0)
        
        addSubview(currencyNameLabel)
        currencyNameLabel.anchor(top: nil, left: flagImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 150, height: 45)
        currencyNameLabel.anchorCenterYToSuperview()
        
        let sepLineView = UIView()
        sepLineView.backgroundColor = .white
        addSubview(sepLineView)
        sepLineView.anchor(top: nil, left: flagImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
}
