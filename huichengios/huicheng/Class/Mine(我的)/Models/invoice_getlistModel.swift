//
//  invoice_getlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//  发票申请  获取列表

import UIKit
import ObjectMapper

class invoice_getlistModel: Mappable {
    var id: Int!
    var type: String!
    var total: String!
    var money: String!
    var state: String!
    var addtime: String!
    var stateStr: String!

    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        total <- map["total"]
        money <- map["money"]
    
        addtime <- map["addtime"]
        stateStr <- map["stateStr"]
        state <- map["state"]

    }
}
