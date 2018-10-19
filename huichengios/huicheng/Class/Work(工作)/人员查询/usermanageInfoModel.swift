//
//  usermanageInfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/10/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

import ObjectMapper

class usermanageInfoModel_info1: Mappable {
    var branch: String!
    var headimg: String!
    var username: String!
    var role: String!
    var department: String!
    var category: String!
    var name: String!
    var sex: String!
    var birthday: String!
    var diploma: String!
    var hometown: String!
    var political: String!
    var idcard: String!
    var mobile: String!
    var phone: String!
    var weixin: String!
    var regaddr: String!
    var addr: String!
    var recordwhere: String!
    var state: String!
    var intime: String!
    var outtime: String!
    var isls: String!





    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        branch <- map["branch"]
        headimg <- map["headimg"]
        username <- map["username"]
        role <- map["role"]
        department <- map["department"]
        category <- map["category"]
        name <- map["name"]
        sex <- map["sex"]
        birthday <- map["birthday"]
        diploma <- map["diploma"]
        hometown <- map["hometown"]
        political <- map["political"]
        idcard <- map["idcard"]
        mobile <- map["mobile"]
        phone <- map["phone"]
        weixin <- map["weixin"]
        regaddr <- map["regaddr"]
        addr <- map["addr"]
        recordwhere <- map["recordwhere"]
        state <- map["state"]
        intime <- map["intime"]
        outtime <- map["outtime"]
        isls <- map["isls"]
    }
}





class usermanageInfoModel: Mappable {
    var info1: usermanageInfoModel_info1 = usermanageInfoModel_info1()
    var info2: usermanageInfoModel_info1 = usermanageInfoModel_info1()
    var info3: usermanageInfoModel_info1 = usermanageInfoModel_info1()
    var info4: usermanageInfoModel_info1 = usermanageInfoModel_info1()
    var info5: usermanageInfoModel_info1 = usermanageInfoModel_info1()
    var info6: usermanageInfoModel_info1 = usermanageInfoModel_info1()
    var info7: usermanageInfoModel_info1 = usermanageInfoModel_info1()

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        info1 <- map["info1"]
        info2 <- map["info2"]
        info3 <- map["info3"]
        info4 <- map["info4"]
        info5 <- map["info5"]
        info6 <- map["info6"]
        info7 <- map["info7"]
    }
}
