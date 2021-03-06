//
//  memo_getlistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//  记录列表
//"id": 10,//ID
//"content": "11111111111111",//内容
//"state": "1已提醒 0为提醒",//提醒状态
//"remindtime": "2016-08-11 17:07:00"//提醒时间
import UIKit
import ObjectMapper

class memo_getlistModel: Mappable {
    var id: Int!
    var content: String!
    var state: Int!
    var stateStr: String!
    var remindtime: String!
    var isremind: Int!
    var isremindStr: String!
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        remindtime <- map["remindtime"]
        state <- map["state"]
        stateStr <- map["stateStr"]
        isremind <- map["isremind"]
        isremindStr <- map["isremindStr"]
    }
}
