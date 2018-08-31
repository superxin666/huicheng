//
//  expense_getlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//  报销申请 获取列表

import UIKit
import ObjectMapper

class expense_getlistModel: Mappable {
    var id: Int!
    var type: String!
    var typeStr: String!
    var total: Int!
    var money: Int!
    var state: Int!
    var addtime: String!
    var stateStr: String!
    
    var user: String!
    var admin: String!


    var branch: String = ""
    var department: String = ""

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        typeStr <- map["typeStr"]
        total <- map["total"]
        money <- map["money"]
        
        addtime <- map["addtime"]
        stateStr <- map["stateStr"]
        state <- map["state"]
        user <- map["user"]
        admin <- map["admin"]

        branch <- map["branch"]
        department <- map["department"]
    }
}
