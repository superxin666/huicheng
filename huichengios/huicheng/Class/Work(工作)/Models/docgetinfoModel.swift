//
//  docgetinfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/5/16.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class docgetinfoModel_imglist: Mappable {

    var url: String!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        url <- map["url"]
    }
}

class docgetinfoModel: Mappable {
    var id: Int!
    var docnum: String!
    var pdf: String!
    var admin: String!
    var applytime: String!
    var addtime : String!
    var note: String!
    var state: Int!
    var stateStr: String!
    var isprint: Int!
    var zhang: String!
    var imglist : [docgetinfoModel_imglist] = []

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        docnum <- map["docnum"]
        pdf <- map["pdf"]
        admin <- map["admin"]
        applytime <- map["applytime"]
        addtime <- map["addtime"]
        note <- map["note"]
        state <- map["state"]
        stateStr <- map["stateStr"]
        isprint <- map["isprint"]
        zhang <- map["zhang"]
        imglist <- map["imglist"]
    }
}
