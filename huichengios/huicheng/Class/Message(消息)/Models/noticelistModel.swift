//
//  noticelistModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//  待办通知 列表获取 数据模型

import UIKit
import ObjectMapper

class noticelistModel: Mappable {
    var id: Int!
    var title: String!
    var type:String!
    var createtime:String!

    var strHeight : CGFloat!

    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        type <- map["type"]
        createtime <- map["createtime"]
        if title.count > 0 {
           strHeight = title.hc_heightWithConstrainedWidth(width: KSCREEN_WIDTH - ip6(30), font: hc_fontThin(16))
        }
    }
    
}
