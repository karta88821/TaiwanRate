//
//  CurrencyListController.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/31.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import UIKit

//protocol CurrencyListDelegate {
//    func changedCurrency(with index: Int)
//}

class CurrencyListController: BaseCollectionViewController {
    
    private let cellId = "cellId"
    
    var currencies = [Currency]()
//
//    var delegate: CurrencyListDelegate?
    
    var didTapCurrencyIndex: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CurrencyListCell.self, forCellWithReuseIdentifier: cellId)
        fetchCurrencies()
    }
    
    fileprivate func fetchCurrencies() {
        service.fetchCurrenciesFromTaiwanBank { (currencies, err) in
            if let err = err {
                print("Failed to fetch currencies: ", err)
                return
            }
            self.currencies = currencies
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let currencyListCell = cell as? CurrencyListCell
        let currency = currencies[indexPath.item]
        currencyListCell?.populate(with: currency)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapCurrencyIndex?(indexPath.item)
        navigationController?.popViewController(animated: true)
    }
}

extension CurrencyListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
