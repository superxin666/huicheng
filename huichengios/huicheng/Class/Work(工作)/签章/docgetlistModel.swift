//
//  docgetlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/5/16.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class docgetlistModel: Mappable {
    var id: Int!
    var docnum: String!
    var dealnum: String!
    var type: Int!
    var typeStr: String!
    var doctype : Int!
    var doctypeStr: String!
    var addtime : String!
    var branch: String!
    var state: Int!
    var stateStr: String!
    var user: String!


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        docnum <- map["docnum"]
        dealnum <- map["dealnum"]
        type <- map["type"]
        typeStr <- map["typeStr"]
        doctype <- map["doctype"]
        doctypeStr <- map["doctypeStr"]
        addtime <- map["addtime"]
        branch <- map["branch"]
        state <- map["state"]
        stateStr <- map["stateStr"]
        user <- map["user"]

    }
}
