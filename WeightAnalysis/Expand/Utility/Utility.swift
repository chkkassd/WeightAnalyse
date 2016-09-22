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
    var md5 : String{
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
    
}
