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
    var code: Int!
    var msg: String = ""
    var data:Any!
    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        code <- map["code"]
        msg <- map["msg"]
        data <- map["data"]
    }
}
