//
//  bank_getlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/5/25.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class bank_getlistModel: Mappable {
    var id: Int!
    var username: String!
    var name: String!
    var subbranch: String!
    var bankname: String!
    var bankcard: String!
    var branch: String!
    var department: String!
    var state: Int!
    var stateStr: String!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        subbranch <- map["subbranch"]
        bankname <- map["bankname"]
        bankcard <- map["bankcard"]
        branch <- map["branch"]
        department <- map["department"]
        state <- map["state"]
        stateStr <- map["stateStr"]
    }
}
