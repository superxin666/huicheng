//
//  departmentModel.swift
//  huicheng
//
//  Created by lvxin on 2018/4/13.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class departmentModel: Mappable {
    var id: Int!
    var name: String!
    var branch: String!

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        branch <- map["branch"]

    }
}
