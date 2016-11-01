//
//  Utility.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 16/9/21.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import Foundation

extension String {
    /**
     Data transform to String
     - Parameters:
       - data:The data of transform
     - Returns: The string transformed from data
     - Authors:
     Peter.Shi
     - date: 2016.9.21
     */
    static func decodeNetwork(data:Data) -> String {
        let originString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        let string = originString?.replacingOccurrences(of: "+", with: " ")
        return string!.replacingPercentEscapes(using: String.Encoding.utf8)!
    }
    
    /**
     A only get computed property that return the md5 string from the origin string.
     - Authors:
     Peter.Shi
     - date: 2016.9.21
     */
    var md5: String{
        let cStr = self.cString(using: String.Encoding.utf8)
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
    
    ///Translate a date string(yy-MM-dd) to Date.
    ///- Authors: Peter.Shi
    ///- date: 2016.10.28
    var translatedDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
}


extension Date {
    
    ///Translate a date of type Date to a date of type String.
    ///- Authors: Peter.Shi
    ///- date: 2016.9.28
    var standardTimeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    ///Translate a date to weekday.
    ///- Authors: Peter.Shi
    ///- date: 2016.10.28
    var weekdayString: String {
        let arr = ["星期六","星期天", "星期一", "星期二", "星期三", "星期四", "星期五"]
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let timeZone = TimeZone(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let calendarComponent = Calendar.Component.weekday
        let theComponents: DateComponents = calendar.dateComponents([calendarComponent], from:self)
        return arr[theComponents.weekday!]
    }
    
    ///Translate a date to weekdayIndex，saturday is 0.
    ///- Authors: Peter.Shi
    ///- date: 2016.11.1
    var weekdayIndex: Int? {
        let calendar = Calendar.current
        let calendarComponent = Calendar.Component.weekday
        let theComponents: DateComponents = calendar.dateComponents([calendarComponent], from:self)
        return theComponents.weekday
    }
    
    ///Fetch the first day of a week by a date.
    ///- Authors: Peter.Shi
    ///- date: 2016.11.1
    var firstDayDate: Date? {
        if let index = self.weekdayIndex {
           return Date(timeInterval: -Double(index * 24 * 60 * 60), since: self)
        }
        return nil
    }

    ///Fetch the last day of a week by a date.
    ///- Authors: Peter.Shi
    ///- date: 2016.11.1
    var lastDayDate: Date? {
        if let index = self.weekdayIndex {
            return Date(timeInterval: Double((6-index) * 24 * 60 * 60), since: self)
        }
        return nil
    }
}
