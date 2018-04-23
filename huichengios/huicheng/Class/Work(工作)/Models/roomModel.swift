//
//  roomModel.swift
//  huicheng
//
//  Created by lvxin on 2018/4/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//  会议室预约 31.1 获取列表

import UIKit
import ObjectMapper

class roomModel: Mappable {
    var id: Int!
    var bt: String!
    var et: String!
    var ut: Int!
    var total: Int!
    var name: String!
    var state: Int!
    var stateStr : String!
    var addtime : String!



    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        bt <- map["bt"]
        et <- map["et"]
        ut <- map["ut"]
        total <- map["total"]
        name <- map["name"]

        state <- map["state"]
        stateStr <- map["stateStr"]
        addtime <- map["addtime"]

    }
}
