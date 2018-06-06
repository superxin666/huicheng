


//
//  sharegetinfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/6/3.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class sharegetinfoModel: Mappable {
    var id: Int!
    var type: Int!
    var typeStr: String!
    var title: String!
    var content: String!
    var user: String!
    var addtime: String!
    var readcount: Int!
    var path: String!
    var filetype: String!


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        typeStr <- map["typeStr"]
        title <- map["title"]
        content <- map["content"]
        user <- map["user"]
        addtime <- map["addtime"]
        readcount <- map["readcount"]
        path <- map["path"]
        filetype <- map["filetype"]
    }
}
