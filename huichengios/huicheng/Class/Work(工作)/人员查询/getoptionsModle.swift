//
//  getoptionsModle.swift
//  huicheng
//
//  Created by lvxin on 2018/10/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class getoptionsModle_content: Mappable {
    var id : Int!
    var name: String = ""

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


class getoptionsModle: Mappable {
    var branch : [getoptionsModle_content] = []
    var department: [getoptionsModle_content] = []
    var category: [getoptionsModle_content] = []
    var diploma: [getoptionsModle_content] = []

    var state: [getoptionsModle_content] = []



    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        branch <- map["branch"]
        department <- map["department"]

        category <- map["category"]
        diploma <- map["diploma"]

    }
}

