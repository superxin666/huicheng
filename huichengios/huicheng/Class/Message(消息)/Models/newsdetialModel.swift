//
//  newsdetialModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//

//"id": 2950,//ID
//"title": "致全体惠诚同仁",//标题
//"content": "<p><br/>全体惠诚同仁明年胜今年!快乐、吉祥、健康、幸
//福永远伴随您! <\/p>",//正文
//"object": "全体职员",//接收对象
//“state”:1//状态 0-未发布;1-已发布;2-已撤回 "stateStr": "已发布",//状态显示文字
//"user": "超级管理员",//发布者
//"createtime": "2017-12-29 08:40:10"//发布时间
import UIKit
import ObjectMapper

class newsdetialModel: Mappable {
    var id: Int!
    var title: String!
    var content:String!
    var object:String!
    var state:Int!
    var objectid:Int!

    var stateStr:String!
    var user:String!
    var createtime:String!
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        object <- map["object"]
        content <- map["content"]
        createtime <- map["createtime"]
        state <- map["state"]
        stateStr <- map["stateStr"]
        user <- map["user"]
        objectid <- map["objectid"]

    }
    
}
