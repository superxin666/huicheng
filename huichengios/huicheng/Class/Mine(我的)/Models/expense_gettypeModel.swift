//
//  expense_gettypeModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/30.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class expense_gettypeModel: Mappable {
    var id: Int!
    var name: String!
    var note: String!
    
    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        note <- map["note"]

        
    }
}
