//
//  noticelistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//  待办通知 列表获取 数据模型

import UIKit
import ObjectMapper

class noticelistModel: Mappable {
    var id: String!
    var title: String!
    var type:String!
    var createtime:String!
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        type <- map["type"]
        createtime <- map["createtime"]
    }
    
}
