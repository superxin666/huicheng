//
//  dealGetlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/4/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class dealGetlistModel: Mappable {
    var id: Int!
    var dealsnum: String!
    var regtime: String!
    var type: String!
    var reguser: String!
    var workersName: String!
    var principal: String!
    var party : String!
    var branch : String!
    var state: Int!
    var stateStr: String!


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        dealsnum <- map["dealsnum"]
        regtime <- map["regtime"]
        type <- map["type"]
        reguser <- map["reguser"]
        workersName <- map["workersName"]

        principal <- map["principal"]
        party <- map["party"]
        branch <- map["branch"]

        state <- map["state"]
        stateStr <- map["stateStr"]

    }
}
