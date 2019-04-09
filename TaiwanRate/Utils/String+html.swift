//
//  String+html.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/31.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import Foundation
import SwiftSoup

extension String {
    func htmlToText() -> String? {
        do {
            let doc: Document = try SwiftSoup.parse(self)
            guard let link = try doc.select("a").first() else { return nil }
            let linkText = try link.text()
            return linkText
        } catch Exception.Error(_, let message) {
            print(message)
            return nil
        } catch {
            print("error")
            return nil
        }
    }
    
    func htmlToImageUrlString() -> String? {
        do {
            let doc: Document = try SwiftSoup.parse(self)
            guard let img = try doc.select("img").first() else { return nil }
            let imgSrc = try img.attr("src")
            return imgSrc
        } catch Exception.Error(_, let message) {
            print(message)
            return nil
        } catch {
            print("error")
            return nil
        }
    }
    
}
