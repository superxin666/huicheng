//
//  quick_getlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//

//"id": 36, //信息 ID
//"type": "法院",//类型
//"name": "111111111",//名称
//"addr": "11111111",//地址
//"contactuser": "333333",//联系人
//"phone": "22222",//电话
//"email": "111111",//邮箱
//"updatetime": "2018-01-17 10:33:52"//更新时间

import UIKit
import ObjectMapper

class quick_getlistModel: Mappable {
    var id: Int!
    var type:String!
    var name: String!
    var addr: String!
    var contactuser: String!
    var phone: String!
    var email: String!
    var updatetime:String!
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        name <- map["name"]
        addr <- map["addr"]
        contactuser <- map["contactuser"]
        phone <- map["phone"]
        email <- map["email"]
        updatetime <- map["updatetime"]
    }
    
}
