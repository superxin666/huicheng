//
//  CrtGetinfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/8/9.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper
class CrtGetinfoModel_items: Mappable {

    var name: String!
    var type: Int!
    var format: String!
    var remark: String!
    var value : String!
    var sort: Int!
    var tagNum: Int!

    var optionArr : [String] = []


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        name <- map["name"]
        type <- map["type"]
        format <- map["format"]
        remark <- map["remark"]
        value <- map["value"]
        sort <- map["sort"]
//        HCLog(message: type)
        if type! == 4 {
            optionArr =  value.components(separatedBy: ",")
            value = optionArr[0]
        }
    }
}

class CrtGetinfoModel_deals: Mappable {
    var id: Int!
    var dealsnum: String!
    var filetype: String!
    var type: String!
    var casename: String!
    var regtime : String!
    var principal: String!
    var content: String!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        dealsnum <- map["dealsnum"]
        filetype <- map["filetype"]
        type <- map["type"]
        casename <- map["casename"]
        regtime <- map["regtime"]
        principal <- map["principal"]
        content <- map["content"]

    }
}


class CrtGetinfoModel: Mappable {
    var deals: CrtGetinfoModel_deals = CrtGetinfoModel_deals()
    var items: [CrtGetinfoModel_items] = []

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        deals <- map["deals"]
        items <- map["items"]
    }
}
