//
//  ImmediateRateController.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/30.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import UIKit
import MBProgressHUD

class ImmediateRateController: BaseCollectionViewController {
    
    var selectedCurrencyIndex = 0
    var currency: Currency?
    var currentDate: String?
    var histories = [Currency]()
    
    private let topHeaderId = "topHeaderId"
    private let sectionId = "sectionId"
    private let section2Id = "sectionId2"
    private let rateDisplayId = "rateDisplayId"
    private let tableFieldId = "tableFieldId"
    private let rateInfoId = "rateInfoId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCellRegister()
        
        setupDates()
        
        setupNavigationItems()
        
        fetchCurrencies(selectedCurrencyIndex) {
            self.hideHUD()
            self.title = self.currency?.countryName
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func setupCellRegister() {
        collectionView.register(ImmediateRateHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: topHeaderId)
        collectionView.register(ImmediateRateSection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionId)
        collectionView.register(ImmediateRateSection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: section2Id)
        collectionView.register(RateDisplayCell.self, forCellWithReuseIdentifier: rateDisplayId)
        collectionView.register(TableFieldCell.self, forCellWithReuseIdentifier: tableFieldId)
        collectionView.register(RateInfoCell.self, forCellWithReuseIdentifier: rateInfoId)
    }
    
    fileprivate func setupDates() {
        currentDate = "刷新時間：" + Date().currentDate()
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        
        let rightBarItems = [UIBarButtonItem(image: UIImage(named: "dollar"), style: .plain, target: self, action: #selector(handleDollar)),
            UIBarButtonItem(image: UIImage(named: "refresh"), style: .plain, target: self, action: #selector(handleRefresh))
        ]
        
        navigationItem.rightBarButtonItems = rightBarItems
        navigationItem.rightBarButtonItems?.forEach { $0.imageInsets =  UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8) }
    }
    
    fileprivate func fetchCurrencies(_ index: Int, completion: @escaping () -> Void) {

        showHud("請稍等...")
        service.fetchCurrenciesFromTaiwanBank { (currencies, err) in
            if let err = err {
                print("Failed to fetch currencies: ", err)
                return
            }
            
            let currentCurrency = currencies[index]
            
            self.currency = currentCurrency
            
            self.service.getFistFiveRate(flag: currentCurrency.flag) { (histories, err) in
                if let err = err {
                    print("Failed to fetch first five rates: ", err)
                    return
                }

                self.histories = histories
                
                DispatchQueue.main.async {
                    completion()
                }
            }
            
        }
    }
    
    @objc func handleMenu() {
        print(123)
    }
    
    @objc func handleRefresh() {
        fetchCurrencies(selectedCurrencyIndex) {
            self.hideHUD()
            self.currentDate = "刷新時間：" + Date().currentDate()
            self.collectionView.reloadData()
        }
    }
    
    @objc func handleDollar() {
        let currencyListController = CurrencyListController(service: service)
        currencyListController.didTapCurrencyIndex = self.didChangedCurrency
        navigationController?.pushViewController(currencyListController, animated: true)
    }
    
    func didChangedCurrency(with index: Int) {
        selectedCurrencyIndex = index
        
        fetchCurrencies(selectedCurrencyIndex) {
            self.hideHUD()
            self.title = self.currency?.countryName
            self.collectionView.reloadData()
        }
    }
    
    // Change collection layout when the device is rotated.
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return 1
        case 2:
            if let currency = currency {
                switch currency.exchangeRate {
                case .cash:
                    return currency.cashExchangeRate.isEmpty ? 0 : histories.count + 1
                case .check:
                    return currency.checkExchangeRate.isEmpty ? 0 : histories.count + 1
                }
            }
            return 0
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rateDisplayId, for: indexPath) as! RateDisplayCell
            cell.currency = currency
            cell.timeLabel.text = currentDate ?? ""
            return cell
        case 2:
            switch indexPath.item {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tableFieldId, for: indexPath) as! TableFieldCell
                return cell
            case 1, 2, 3, 4, 5:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rateInfoId, for: indexPath) as! RateInfoCell
                cell.history = histories[indexPath.item - 1]
                cell.exchangedRate = currency?.exchangeRate
                return cell
            default:
                return UICollectionViewCell()
            }
        default:
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            switch indexPath.section {
            case 0:
                let topHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: topHeaderId, for: indexPath) as! ImmediateRateHeader
                return topHeader
            case 1:
                let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionId, for: indexPath) as! ImmediateRateSection
                section.type = .todayRate
                section.exchangeRate = currency?.exchangeRate
                section.delegate = self 
                return section
            case 2:
                let section = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: section2Id, for: indexPath) as! ImmediateRateSection
                section.type = .topFiveRate
                return section
            default:
                assert(false, "Unexpected header")
            }
        }

        assert(false, "Unexpected element kind")
    }
}

extension ImmediateRateController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 1:
            return CGSize(width: view.frame.width, height: 100 + 30)
        case 2:
            if histories.isEmpty {
                return .zero
            }
            return CGSize(width: view.frame.width, height: 35)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: view.frame.width, height: 16 + 16 + 30)
        case 1, 2:
            return CGSize(width: view.frame.width, height: 30)
        default:
            return .zero
        }
    }
}

extension ImmediateRateController: ImmediateRateSectionDelegate {
    func changedExchangedRate() {
        currency?.exchangeRate.reverse()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//extension ImmediateRateController: CurrencyListDelegate {
//    func changedCurrency(with index: Int) {
//        selectedCurrencyIndex = index
//
//        fetchCurrencies(selectedCurrencyIndex) {
//            self.hideHUD()
//            self.title = self.currency?.countryName
//            self.collectionView.reloadData()
//        }
//    }
//}
