//
//  xpense_getinfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/20.
//  Copyright © 2018年 lvxin. All rights reserved.
// 报销详情
//"id": 119,//ID
//"type": 1,//报销类型
//"typeStr": "差旅费",
//报销类型显示文字 "total": 44,//单据数量
//"money": 444444,//报销金额
//"state": 0,//状态
//"stateStr": "未审核",
//状态显示文字 "addtime": "2018-02-27 16:26:43"//申请时间

import UIKit
import ObjectMapper

class expense_getinfoModel_data: Mappable {
    var id: Int!
    var type: Int!
    var typeStr: String!
    var typeNote: String!
    
    var total: Int!
    var money: Int!

    /// 0-未审核;1-已审核;2-审核驳回;3-已支付;4-支付信息驳回
    var state: Int!
    var stateStr: String!
    var addtime: String!
    var replaytime: String!
    var admin: String!



    var note: String!

    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        typeStr <- map["typeStr"]
        replaytime <- map["replaytime"]
        admin <- map["admin"]



        total <- map["total"]
        money <- map["money"]
        typeNote <- map["typeNote"]

        addtime <- map["addtime"]
        stateStr <- map["stateStr"]
        state <- map["state"]

        note <- map["note"]

        
    }
}

class expense_getinfoModel: Mappable {
    var data: expense_getinfoModel_data!
    var type: [expense_gettypeModel] = []


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        data <- map["data"]
        type <- map["type"]

    }
}

