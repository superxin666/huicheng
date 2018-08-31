//
//  getdetailModel.swift
//  huicheng
//
//  Created by lvxin on 2018/8/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class getdetailModel_document: Mappable {
    var id: Int!
    var addtime: String!
    var num: String!
    var type: String!
    var user: String!
    var state: String!


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        addtime <- map["addtime"]
        type <- map["type"]
        num <- map["num"]
        state <- map["state"]
        user <- map["user"]

    }
}



class getdetailModel_income: Mappable {
    var id: Int!
    var addtime: String!
    var payuser: String!
    var amount: Int!
    var ispaper: String!
    var note: String!
    var state: String!
    var user: String!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        addtime <- map["addtime"]
        payuser <- map["payuser"]

        amount <- map["amount"]
        ispaper <- map["ispaper"]
        note <- map["note"]


        state <- map["state"]
        user <- map["user"]

    }
}



class getdetailModel: Mappable {
    var data: getinfoDealModel = getinfoDealModel()
    var income: [getdetailModel_income] = []
    var document : [getdetailModel_document]  = []


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        data <- map["data"]
        income <- map["income"]
        document <- map["document"]
    }
}
