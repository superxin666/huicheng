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
    var dealsnum: String!

    var addtime: String!
    var amount: String!
    var amountInt : Int!

    var money: Int!

    var type: String!
    var typeStr: String!
    var principal: String!
    var papernum: String!
    var state: Int!
    var stateStr: String!

    var regtime :String!
    var reguser :String!
    var workersName :String!
    var party :String!
    var branch :String!
    var user :String!

    var admin :String!
    var applytime :String!
    var note :String!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        dealnum <- map["dealnum"]
        dealsnum <- map["dealsnum"]
        addtime <- map["addtime"]

        amount <- map["amount"]
        amountInt <- map["amount"]
        money <- map["money"]

        type <- map["type"]
        typeStr <- map["typeStr"]
        principal <- map["principal"]
        papernum <- map["papernum"]
        state <- map["state"]
        stateStr <- map["stateStr"]
        regtime <- map["regtime"]
        reguser <- map["reguser"]
        workersName <- map["workersName"]
        party <- map["party"]
        branch <- map["branch"]
        user <- map["user"]
        admin <- map["admin"]
        applytime <- map["applytime"]
        note <- map["note"]



    }

}
