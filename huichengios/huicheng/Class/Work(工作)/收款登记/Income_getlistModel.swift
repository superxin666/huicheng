//
//  Income_getlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/7/6.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class Income_getlistModel: Mappable {
    var id: Int!
    var dealnum: String!
    var addtime: String!
    var amount: String!
    var type: String!
    var typeStr: String!
    var principal: String!
    var papernum: String!
    var state: String!
    var stateStr: String!



    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        dealnum <- map["dealnum"]
        addtime <- map["addtime"]
        amount <- map["amount"]
        type <- map["type"]
        typeStr <- map["typeStr"]
        principal <- map["principal"]
        papernum <- map["papernum"]
        state <- map["state"]
        stateStr <- map["stateStr"]
    }

}
