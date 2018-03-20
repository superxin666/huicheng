//
//  user_getinfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class user_getinfoModel: Mappable {
    var face: String!
    var name: String!
    var username: String!
    var department: String!
    var role: String!
    var practicing: String!
    var mobile: String!
    var sex: String!
    var diploma: String!
    var hometown: String!
    var political: String!
    var intime: String!
    var idcard: String!
    var addr: String!
    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        face <- map["face"]
        name <- map["name"]
        username <- map["username"]
        department <- map["department"]
        role <- map["role"]
        mobile <- map["mobile"]
        sex <- map["sex"]
        diploma <- map["diploma"]
        hometown <- map["hometown"]
        political <- map["political"]
        intime <- map["intime"]
        idcard <- map["idcard"]
        addr <- map["addr"]
        practicing <- map["practicing"]

    }
}
