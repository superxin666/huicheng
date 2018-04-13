//
//  branchModel.swift
//  huicheng
//
//  Created by lvxin on 2018/4/13.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class branchModel: Mappable {
    var id: Int!
    var name: String!
    var showname: String!
    var nostr: String!
    var img: String!
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        showname <- map["showname"]
        nostr <- map["nostr"]
        img <- map["img"]
    }
}
