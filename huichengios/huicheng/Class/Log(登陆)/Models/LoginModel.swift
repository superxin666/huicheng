//
//  LoginModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginModel_power: Mappable {
    var name: String!
    var childrens: [String] = []



    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        name <- map["name"]
        childrens <- map["childrens"]

//        childrens = childrens.reversed()

    }

}


class LoginModel: Mappable {
    var name: String!
    var msg: String!
    var branch:String!
    var key:String!
    var power:[LoginModel_power] = []
    var searchpower: [Int] = []
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        name <- map["name"]
        msg <- map["msg"]
        branch <- map["branch"]
        key <- map["key"]
        power <- map["power"]
        searchpower <- map["searchpower"]
    }

}
