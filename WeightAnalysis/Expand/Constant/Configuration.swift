//
//  Configuration.swift
//  WeightAnalysis
//
//  Created by 赛峰 施 on 2016/11/29.
//  Copyright © 2016年 赛峰 施. All rights reserved.
//

import Foundation

public let serverIp = "120.24.67.134"
public let serverPort = "8080"

#if DEBUG
    //debug model configuration
#elseif UAT
    //uat model configuration
#else
    //release model configuration
#endif
