//
//  BaseCollectionViewController.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/30.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {
    
    let service: NetworkService

    init(service: NetworkService) {
        self.service = service
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .defaultBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
