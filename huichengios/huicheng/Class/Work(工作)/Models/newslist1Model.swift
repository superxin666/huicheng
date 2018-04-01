//
//  newslist1Model.swift
//  huicheng
//
//  Created by lvxin on 2018/4/1.
//  Copyright © 2018年 lvxin. All rights reserved.
//  公告管理  获取列表
//"id": 3025, //公告 ID
//"title": "444444444444",//标题
//"object": "北京公告组",//接收对象
//"user": "超级管理员",//发布者
//"branch": "北京总部",//所属分所
//"createtime": "2018-03-25 22:53:42",//发布时间 "isread": "未读",//阅读状态
//"state": "未发布"//发布状态

import UIKit
import ObjectMapper

class newslist1Model: Mappable {
    var id: Int!
    var title: String!
    var object: String!
    var user: String!
    var branch: String!
    var createtime: String!
    var isread: String!
    var state: String!

    
    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        object <- map["object"]
        user <- map["user"]
        branch <- map["branch"]
        createtime <- map["createtime"]
        isread <- map["isread"]
        state <- map["state"]

    }
}
