//
//  shareGetlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/4/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//
//"id": 1, //模板 ID
//"type": 3, //类型 1-诉讼案件;2-非诉案件;3-刑事案件;4-法律顾问;5- 采购合同;6-资质文件;
//"typeStr": "刑事案件",//类型显示文字
//"title": "asdfas",//标题
//"user": "超级管理员",//发布者
//"readcount": 3, //阅读次数
//"addtime": "2018-01-21 08:02:35"//发布时间

import UIKit
import ObjectMapper

class shareGetlistModel: Mappable {
    var id: Int!
    var type: Int!
    var typeStr: String!
    var title: String!
    var user: String!
    var readcount : Int!
    var addtime : String!

    var ifedit: Int!



    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        typeStr <- map["typeStr"]
        title <- map["title"]
        user <- map["user"]
        readcount <- map["readcount"]
        addtime <- map["addtime"]

        ifedit <- map["ifedit"]

    }
}
