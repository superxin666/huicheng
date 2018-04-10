//
//  invoice_getlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//  发票申请  获取列表
//"id": 450,//ID
//"type": "增值税普通发票",//发票类型
//"title": "4t32t34t",//发票抬头
//"money": 454,//发票金额
//"sendtype": "上门自取",//送达方式
//"addtime": "2018-02-27 16:27:43",
//申请时间 "state": "未审核"//申请状态


import UIKit
import ObjectMapper

class invoice_getlistModel: Mappable {
    var id: Int!
    var type: String!
    var titlesStr: String!
    var money: Int!
    var sendtype: Int!
    var sendtypeStr: String!
    var addtime: String!
    var state: Int!
    var stateStr: String!
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        titlesStr <- map["title"]
        money <- map["money"]
        sendtype <- map["sendtype"]
        addtime <- map["addtime"]
        state <- map["state"]
        sendtypeStr <- map["sendtypeStr"]
        stateStr <- map["stateStr"]
    }
}
