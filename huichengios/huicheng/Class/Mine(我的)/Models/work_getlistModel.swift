//
//  work_getlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  工作日志 获取列表

//"id": 2, //ID
//"title": "222222",//标题
//"addtime": "2018-02-19 18:28:01"//发布时间
import UIKit
import ObjectMapper

class work_getlistModel: Mappable {
    var id: Int!
    var title: String!
    var addtime: String!
    
    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        addtime <- map["addtime"]

    }
}
