//
//  finance_getinfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/20.
//  Copyright © 2018年 lvxin. All rights reserved.
// 我的收款  查看详情
//说明:当 state 大于 0，显示审核人和审核时间，如果为 2，则再加入驳回信息的显 示;如果为 3，则显示经办人和支付时间。
//"id": 438,//ID
//"num": "HTBJ20172422",//合同编号
//"principal": "刘蕾",//委托人
//"dealamount": "10000",//合同金额
//"paymoney": 5000, //已付金额
//"user": "吴名氏",//收款律师
//"type": 0, //收款类型 0-提成;1-报销
//"typeStr": "提成",//收款显示文字
//"money": 1492.2, //金额
//"addtime": "2017-09-12 14:36:43",//信息创建时间
//"state": 3, //收款状态 0-未审核;1-已审核;2-审核驳回;3-已支付;
//"stateStr": "已支付",//收款状态显示文字
//"bank": "交通银行",//收款银行
//"cardno": "6222600910054744931",//银行卡号
//"applyname": "么华颖",//审核人
//"applytime": "2017-09-19 14:29:15",//审核时间
//"note": "",//驳回信息或反馈信息，state 为 2 时显示
//"funadmin": "超级管理员",//经办人
//"paytime": "2017-09-19 14:35:28"//支付时间

import UIKit
import ObjectMapper

class finance_getinfoModel: Mappable {
    var id: Int!
    var num: String!
    var principal: String!
    var dealamount: Int!
    var paymoney: Int!
    var user: String!
    
    var type: Int!
    var typeStr: String!
    var money: Float!
    var addtime: String!
    var state: Int!
    var stateStr: String!
    var bank: String!
    var cardno: String!
    var applyname: String!
    var note: String!
    var funadmin: String!
    var paytime: String!
    var applytime: String!

    
    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        num <- map["num"]
        principal <- map["principal"]
        dealamount <- map["dealamount"]
        paymoney <- map["paymoney"]
        user <- map["user"]
        type <- map["type"]
        typeStr <- map["typeStr"]
        money <- map["money"]
        addtime <- map["addtime"]
        state <- map["state"]
        stateStr <- map["stateStr"]
        bank <- map["bank"]
        cardno <- map["cardno"]
        applyname <- map["applyname"]
        note <- map["note"]
        funadmin <- map["funadmin"]
        paytime <- map["paytime"]
        applytime <- map["applytime"]
    }
}
