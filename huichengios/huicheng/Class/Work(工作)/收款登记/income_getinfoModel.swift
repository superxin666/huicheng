
//
//  income_getinfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/7/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class income_getinfoModel_data: Mappable {

    var id: Int!
    var dealnum: String!
    var principal: String!

    var reguser: String!
    var regtime: String!

    var dealamount: Int!
    var dealmoney: Int!
    var addtime: String!
    var payuser: String!

    var ispaper :Int!
    var ispaperStr :String!
    var papernum :String!
    var creditcode :String!
    var amount :Int!
    var money :Int!

    var state :Int!
    var stateStr :String!
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
        principal <- map["principal"]
        reguser <- map["reguser"]
        regtime <- map["regtime"]
        dealamount <- map["dealamount"]
        dealmoney <- map["dealmoney"]
        addtime <- map["addtime"]
        payuser <- map["payuser"]
        ispaper <- map["ispaper"]
        ispaperStr <- map["ispaperStr"]
        papernum <- map["papernum"]
        creditcode <- map["creditcode"]
        amount <- map["amount"]
        money <- map["money"]
        state <- map["state"]
        stateStr <- map["stateStr"]
        admin <- map["admin"]
        applytime <- map["applytime"]
        note <- map["note"]
    }

}

class income_getinfoModel_items: Mappable {

    var id: Int!
    var type: String!
    var typeStr: String!

    var cost: Int!
    var amount: Int!
    var money: Int!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        typeStr <- map["typeStr"]
        cost <- map["cost"]
        amount <- map["amount"]
        money <- map["money"]
    }

}

class income_getinfoModel: Mappable {

    var data :income_getinfoModel_data = income_getinfoModel_data()
    var items : [income_getinfoModel_items] = []

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        data <- map["data"]
        items <- map["items"]

    }

}
