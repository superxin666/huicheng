
//
//  crt_chooseModel.swift
//  huicheng
//
//  Created by lvxin on 2018/8/9.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class crt_chooseModel: Mappable {
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
