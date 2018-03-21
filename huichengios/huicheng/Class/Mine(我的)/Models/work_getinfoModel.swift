//
//  work_getinfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  工作日志 查看详情

import UIKit
import ObjectMapper

class work_getinfoModel: Mappable {
    var id: Int!
    var title: String!
    var content: String!
    var user: String!
    var attachment: String!
    var addtime: String!
    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        content <- map["content"]
        user <- map["user"]
        attachment <- map["attachment"]
        addtime <- map["addtime"]
        
    }
}
