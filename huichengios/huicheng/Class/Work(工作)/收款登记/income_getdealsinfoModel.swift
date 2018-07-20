//
//  income_getdealsinfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/7/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper
class income_getdealsinfoModel: Mappable {

    var data :Income_getlistModel = Income_getlistModel()
    var income : [Income_getlistModel] = []

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        data <- map["data"]
        income <- map["income"]

    }

}
