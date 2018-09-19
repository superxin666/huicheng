//
//  income_getcountModel.swift
//  huicheng
//
//  Created by lvxin on 2018/9/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class income_getcountModel: Mappable {
    var id: Int!
    var username: String = ""
    var name: String = ""
    var addtime: String = ""
    var dealnum: String = ""
    var principal: String = ""
    var papernum: String = ""
    var invoicetype: String = ""
    var type: String = ""
    var cost: Float!
    var money: Float!
    var pick: Int!
    var state: String = ""
    var balance: Int!



    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        name <- map["name"]
        addtime <- map["addtime"]
        dealnum <- map["dealnum"]
        principal <- map["principal"]
        papernum <- map["papernum"]
        invoicetype <- map["invoicetype"]
        type <- map["type"]
        cost <- map["cost"]
        money <- map["money"]
        pick <- map["pick"]
        state <- map["state"]
        balance <- map["balance"]
    }
}
