//
//  usermanageModel.swift
//  huicheng
//
//  Created by lvxin on 2018/10/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class usermanageModel: Mappable {
    var id: Int!
    var username: String!
    var name: String!
    var branch: String!
    var department: String!
    var category: String!
    var diploma: String!
    var addtime: String!
    var state: Int!
    var stateStr: String!



    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        name <- map["name"]
        branch <- map["branch"]
        department <- map["department"]
        category <- map["category"]
        diploma <- map["diploma"]
        addtime <- map["addtime"]
        state <- map["state"]
        stateStr <- map["stateStr"]
    }
}
