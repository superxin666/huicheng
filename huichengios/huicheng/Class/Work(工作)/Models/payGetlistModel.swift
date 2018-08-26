//
//  payGetlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/8/26.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class payGetlistModel: Mappable {
    var id: Int!
    var num: String!
    var user: String!
    var type: Int!
    var typeStr: String!
    var money: Int!
    var addtime: String!
    var state: Int!
    var stateStr: String!


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        num <- map["num"]
        user <- map["user"]
        type <- map["type"]
        money <- map["money"]


        typeStr <- map["typeStr"]
        addtime <- map["addtime"]
        state <- map["state"]
        stateStr <- map["stateStr"]

    }
}
