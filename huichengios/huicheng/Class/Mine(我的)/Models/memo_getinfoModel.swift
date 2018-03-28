//
//  memo_getinfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//  记录详情
//"id": 13,//ID
//"content": "测试时了空间按声卡了典范",//内容 "state": 1,//状态 0-未提醒;1-已提醒 "stateStr": "已提醒",//状态显示字符
//"isremind": 1,//是否提醒 0-不提醒;1-提醒 "isremindStr": "是",//是否提醒显示字符 "remindtime": "2016-08-11 18:05:00"//提醒时间

import UIKit
import ObjectMapper

class memo_getinfoModel: Mappable {
    var id: Int!
    var content: String!
    var state: Int!
    var stateStr: String!
    var isremind: Int!
    var isremindStr: String!
    var remindtime: String!
    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        state <- map["state"]
        stateStr <- map["stateStr"]
        isremind <- map["isremind"]
        isremindStr <- map["isremindStr"]
        remindtime <- map["remindtime"]

    }
}
