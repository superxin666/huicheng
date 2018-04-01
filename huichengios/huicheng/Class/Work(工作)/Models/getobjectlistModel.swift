//
//  getobjectlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/4/1.
//  Copyright © 2018年 lvxin. All rights reserved.
//
//"id": 1, //接收对象 ID
//"name": "全体职员"//接收对象名称

import UIKit
import ObjectMapper

class getobjectlistModel: Mappable {
    var id: Int!
    var name: String!


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]

    }
}
