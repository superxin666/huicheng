

//
//  pay_applyinfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/8/27.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

import ObjectMapper

class pay_applyinfoModel_data: Mappable {
    var id: Int!
    var num: String!
    var principal: String!
    var dealamount: Int!

    var paymoney: String!
    var user: String!
    var type: Int!
    var typeStr: String!
    var money: Int!


    var addtime: String!
    var state: Int!
    var stateStr: String!
    var bank: String!

    var cardno: String!
    var applyname: String!
    var applytime: String!
    var funadmin: String!
    var paytime: String!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        num <- map["num"]
        principal <- map["principal"]
        dealamount <- map["dealamount"]
        paymoney <- map["paymoney"]
        user <- map["user"]
        type <- map["type"]
        typeStr <- map["typeStr"]
        money <- map["money"]

        addtime <- map["addtime"]
        state <- map["state"]
        stateStr <- map["stateStr"]
        bank <- map["bank"]
        cardno <- map["cardno"]
        applyname <- map["applyname"]
        applytime <- map["applytime"]
        funadmin <- map["funadmin"]
        paytime <- map["paytime"]


    }
}


class pay_applyinfoModel: Mappable {
    var data: pay_applyinfoModel_data = pay_applyinfoModel_data()
    var expense: expense_getinfoModel_data = expense_getinfoModel_data()
    var income: income_getinfoModel_data = income_getinfoModel_data()



    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        data <- map["data"]
        expense <- map["expense"]
        income <- map["income"]
    }
}
