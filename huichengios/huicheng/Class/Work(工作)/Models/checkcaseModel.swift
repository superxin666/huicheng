//
//  checkcaseModel.swift
//  huicheng
//
//  Created by lvxin on 2018/4/1.
//  Copyright © 2018年 lvxin. All rights reserved.
//  利益冲突检查数据模型
//"id": 2313, //ID
//"name": "物业纠纷案",//案件名称
//"regtime": "2017-07-04 00:00:00",//立案时间 "type": "诉讼案件",//案件类型
//"reguser": "张三",//立案律师
//"workersName": "李四",//承办律师
//"department": "金融证券部",//所属部门 "user": "王五",//录入人
//"addtime": "2017-07-05 09:12:26",//录入时间 "branch": "北京分所"//所属分所

import UIKit
import ObjectMapper

class checkcaseModel: Mappable {
    var id: Int!
    var name: String!
    var regtime: String!
    var type: String!
    var reguser: String!
    var workersName: String!
    var department: String!
    var user: String!
    var addtime: String!
    var branch: String!

    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        regtime <- map["regtime"]
        type <- map["type"]
        reguser <- map["reguser"]
        workersName <- map["workersName"]
        department <- map["department"]
        user <- map["user"]
        addtime <- map["addtime"]
        branch <- map["branch"]
    }
}
