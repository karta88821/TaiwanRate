//
//  Date+format.swift
//  TaiwanRate
//
//  Created by liao yuhao on 2018/10/31.
//  Copyright © 2018 liao yuhao. All rights reserved.
//

import Foundation

//Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
//09/12/2018                        --> MM/dd/yyyy
//09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
//Sep 12, 2:11 PM                   --> MMM d, h:mm a
//September 2018                    --> MMMM yyyy
//Sep 12, 2018                      --> MMM d, yyyy
//Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
//2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
//12.09.18                          --> dd.MM.yy

extension Date {
    func currentDate() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let currentDate = dateFormat.string(from: self)
        return currentDate
    }
    
    func currentYear() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy"
        let currentDate = dateFormat.string(from: self)
        return currentDate
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self) ?? Date()
    }
    
    func today() -> String {
        let date = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy/MM/dd"
        return dateFormat.string(from: date)
    }
    
    func yesterday() -> String {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date().noon) ?? Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd"
        
        let yesterday = format.string(from: date)
        
        return yesterday
    }
    
    static var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date().noon) ?? Date()
    }
    
    func getRecentDates(days: Int) -> [String] {
        return (1...days).map{ day -> String in
            guard let date = Calendar.current.date(byAdding: .day, value: 0 - day, to: Date().noon) else { return "" }
            
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "MM/dd"
            let currentDate = dateFormat.string(from: date)

            return currentDate
        }
    }
}
