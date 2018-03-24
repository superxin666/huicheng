//
//  finance_getlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//我的收款  获取列表
//"id": 438,//ID
//"num": "HTBJ20172422",//合同号
//"user": "吴名氏",//收款用户姓名
//"type": "提成",//收款类型
//"money": 1492.2,//收款金额
//"addtime": "2017-09-12 14:36:43",//生成时间 "state": "已支付"//收款状态

import UIKit
import ObjectMapper

class finance_getlistModel: Mappable {
    var id: Int!
    var num: String!
    var user: String!
    var type: String!
    var money: Int!
    var addtime: String!
    var state: String!
    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        num <- map["num"]
        user <- map["user"]
        type <- map["type"]
        money <- map["money"]
        addtime <- map["addtime"]
        
        state <- map["state"]
    }
}
