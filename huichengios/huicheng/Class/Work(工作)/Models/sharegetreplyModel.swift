//
//  sharegetreplyModel.swift
//  huicheng
//
//  Created by lvxin on 2018/6/3.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class sharegetreplyModel: Mappable {
    var id: Int!
    var user: String!
    var content: String!
    var addtime: String!



    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        user <- map["user"]
        content <- map["content"]
        addtime <- map["addtime"]
    }
}
