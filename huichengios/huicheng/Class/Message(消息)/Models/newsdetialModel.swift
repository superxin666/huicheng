//
//  newsdetialModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class newsdetialModel: Mappable {
    var id: Int!
    var title: String!
    var content:String!
    var object:String!
    var state:String!
    var user:String!
    var createtime:String!
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        object <- map["object"]
        content <- map["content"]
        createtime <- map["createtime"]
        state <- map["state"]
        user <- map["user"]
    }
    
}
