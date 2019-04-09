//
//  NetworkService.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/31.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import Foundation
import Alamofire
import SwiftSoup
import Kanna

// Design Patterns
// 1. Composition

//https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908
//https://www.natashatherobot.com/protocol-oriented-networking-in-swift/

class NetworkService {
    
    private let baseUrl = "https://tw.rter.info"
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchCurrenciesFromTaiwanBank(complection: @escaping ([Currency], Error?) -> Void) {
        var currencies = [Currency]()
        
        let urlString = "https://rate.bot.com.tw/xrt?Lang=zh-TW"
        
        Alamofire.request(urlString).responseString { (response) in
            if let err = response.error {
                complection(currencies, err)
                return
            }
            
            guard let html = response.result.value else { return }
            
            guard let doc = try? Kanna.HTML(html: html, encoding: .utf8) else { return }
            
            (1...19).forEach { xIndex in
                var rates = [String]()
                
                guard let counturyColumn = doc.xpath("/html/body/div[1]/main/div[3]/table/tbody/tr[\(xIndex)]/td[1]/div/div[2]").first else { return }
                
                let coutryName = counturyColumn.text?.withoutSpacing().withoutParentheses ?? "..."
                
                (2...5).forEach { yIndex in
                    let rate = self.parseHTML(html: html, xpath: "/html/body/div[1]/main/div[3]/table/tbody/tr[\(xIndex)]/td[\(yIndex)]")
                    
                    rates.append(rate)
                }
                
                let cashRate = Rate(buy: rates[0], sell: rates[1])
                let checkRate = Rate(buy: rates[2], sell: rates[3])
                
                let currency = Currency(exchangeRate: .cash, date: nil, countryName: coutryName, cashExchangeRate: cashRate, checkExchangeRate: checkRate)

                currencies.append(currency)
            }
            
            DispatchQueue.main.async {
                complection(currencies, nil)
            }
            
        }
    }
    
    private func parseHTML(html: String, xpath: String) -> String {
        
        guard let doc = try? Kanna.HTML(html: html, encoding: .utf8),
            let result = doc.xpath(xpath).first else { return ""}
        
        let text = result.text?.withoutSpacing() ?? ""
        
        return text
    }
    
    func fetchCurrenciesFromBank(_ exchangeRate: ExchangeRate, bank: BankType,
                                 complection: @escaping ([Currency], Error?) -> ()) {
        
        let exchangeRate = exchangeRate.rawValue
        guard let swiftCode = bank.swiftCode else { return }
        guard let url = URL(string: baseUrl + "/json.php?t=bank&q=\(exchangeRate)&iso=\(swiftCode)") else { return }
        
        let headers = ["cache-control": "s-maxage=10",
                       "content-encoding": "gzip",
                       "content-type": "application/json",
                       "server": "Apache/2.4.25",
                       "vary": "Accept-Encoding"]
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let dataTask = session.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Failed to fetch all currencies: ", err)
                return
            }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                guard let dic = json as? [String: Any] else { return }
                guard let currencyArray = dic["data"] as? [[String]] else { return }
                
//                let currencies = currencyArray.map{ Currency(name: $0[0].htmlToText() ?? "", buyPrice: $0[1], sellPrice: $0[2])}
                
                complection([], nil)
                
                
            } catch let err {
                complection([], err)
            }
        }
        
        dataTask.resume()
    }

    func getFistFiveRate(flag: Flag, completion: @escaping ([Currency], Error?) -> Void ) {
        Alamofire.request("https://rate.bot.com.tw/xrt/quote/ltm/\(flag.rawValue)").responseString { (response) in
            if let err = response.error {
                completion([], err)
                return
            }
            
            guard let html = response.result.value else { return }
            guard let doc = try? HTML(html: html, encoding: .utf8) else { return }

            guard let firstColumn = doc.xpath("/html/body/div[1]/main/div[3]/table/tbody/tr[1]").first else { return }
            
            let firstColumnDate = firstColumn.xpath("child::*").map{ $0.text?.withoutSpacing() ?? "" }[0]

            let currencies = self.parseTableColumn(doc, firstColumnDate: firstColumnDate)

            completion(currencies, nil)
        }
    }
    
    fileprivate func parseTableColumn(_ doc: HTMLDocument , firstColumnDate: String) -> [Currency] {

        if firstColumnDate == Date().today() {
            return setupCurrencyForHistory(doc: doc, startIndex: 2, endIndex: 6)
        } else {
            return setupCurrencyForHistory(doc: doc, startIndex: 1, endIndex: 5)
        }
    }
    
    fileprivate func setupCurrencyForHistory(doc: HTMLDocument, startIndex: Int, endIndex: Int) -> [Currency] {
        
        let baseTableXpath = "/html/body/div[1]/main/div[3]/table/tbody"
        
        let trTags = (startIndex...endIndex).map{ doc.xpath(baseTableXpath + "/tr[\($0)]")[0]}
        
        let histories = trTags.map{$0.xpath("child::*")
            .map{$0.text?.withoutSpacing() ?? "" }}
        
        return histories.map { history -> Currency in
            return Currency(exchangeRate: .cash,
                            date: history[0],
                            countryName: history[1],
                            cashExchangeRate: Rate(buy: history[2], sell: history[3]),
                            checkExchangeRate: Rate(buy: history[4], sell: history[5]))
        }
    }
    
}
