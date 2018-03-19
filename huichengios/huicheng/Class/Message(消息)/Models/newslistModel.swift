//
//  newslistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class newslistModel: Mappable {
    var id: String!
    var title: String!
    var object:String!
    var createtime:String!
    var user:String!

    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        object <- map["object"]
        createtime <- map["createtime"]
    }
    
}
