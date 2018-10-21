//
//  usermanageInfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/10/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

import ObjectMapper

class usermanageInfoModel_info7: Mappable {


    //附件管理
    var id : Int!
    var name: String = ""
    var files: String = ""
    var addtime: String = ""




    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]

        files <- map["files"]
        addtime <- map["addtime"]

    }
}



class usermanageInfoModel_info6: Mappable {


    //合同管理
    var id : Int!
    var begintime: String = ""
    var endtime: String = ""
    var type: String = ""
    var proportion: Int!
    var salary: Int!

    var img: String = ""


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        begintime <- map["begintime"]
        endtime <- map["endtime"]
        type <- map["type"]
        proportion <- map["proportion"]
        salary <- map["salary"]
        img <- map["img"]

    }
}


class usermanageInfoModel_info5: Mappable {


    //社保情况
    var insurance_basemoney :  String = ""
    var insurance_starttime: String = ""
    var insurance_endtime: String = ""
    var fund_basemoney: String = ""
    var fund_starttime: String = ""
    var fund_endtime: String = ""



    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        insurance_basemoney <- map["insurance_basemoney"]
        insurance_starttime <- map["insurance_starttime"]
        insurance_endtime <- map["insurance_endtime"]
        fund_basemoney <- map["fund_basemoney"]
        fund_starttime <- map["fund_starttime"]
        fund_endtime <- map["fund_endtime"]
    }
}



class usermanageInfoModel_info4: Mappable {


    //奖惩信息
    var id : Int!
    var type: String = ""
    var addtime: String = ""
    var content: String = ""
    var awardlevel: String = ""
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        addtime <- map["addtime"]
        content <- map["content"]
        awardlevel <- map["awardlevel"]
    }
}





class usermanageInfoModel_info3_train: Mappable {


    //o培训
    var id : Int!
    var begintime: String = ""
    var endtime: String = ""
    var content: String = ""
    var paper: String = ""




    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        begintime <- map["begintime"]
        endtime <- map["endtime"]
        content <- map["content"]
        paper <- map["paper"]
    }
}


class usermanageInfoModel_info3_school: Mappable {


    //教育经历
    var id : Int!
    var begintime: String = ""
    var endtime: String = ""
    var school: String = ""
    var project: String = ""
    var diploma: String = ""

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {

        id <- map["id"]
        begintime <- map["begintime"]
        endtime <- map["endtime"]
        school <- map["school"]
        project <- map["project"]
        diploma <- map["diploma"]

    }
}



class usermanageInfoModel_info3: Mappable {
    var language_en: String = ""
    var language_jp: String = ""
    var language_other: String = ""
    var languagelevel: String = ""
    var office: String = ""
    var printspeed: String = ""

//教育经历
    var school : [usermanageInfoModel_info3_school] = []

//o培训
    var train : [usermanageInfoModel_info3_train] = []

    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        language_en <- map["language_en"]
        language_jp <- map["language_jp"]
        language_other <- map["language_other"]
        languagelevel <- map["languagelevel"]
        office <- map["office"]
        printspeed <- map["printspeed"]
        school <- map["school"]
    }
}

class usermanageInfoModel_info2_family: Mappable {


    var id : Int!
    var relation: String = ""
    var name: String = ""
    var work: String = ""
    var job: String = ""
    var phone: String = ""





    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {

        id <- map["family"]["id"]
        relation <- map["family"]["relation"]
        name <- map["family"]["name"]
        work <- map["family"]["work"]
        job <- map["family"]["job"]
        phone <- map["family"]["phone"]
    }
}

class usermanageInfoModel_info2: Mappable {
    var subbranch: String = ""
    var bankcard: String = ""
    var bankname: String = ""
    var cardimg: String = ""
    var diplomaimg: String = ""
    var jobimg: String = ""
    var features: String = ""
    var certificate: String = ""
    var practicing: String = ""
    var background: String = ""

    var family: [usermanageInfoModel_info2_family] = []





    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        subbranch <- map["subbranch"]
        bankcard <- map["bankcard"]
        bankname <- map["bankname"]
        cardimg <- map["cardimg"]
        diplomaimg <- map["diplomaimg"]
        jobimg <- map["jobimg"]
        features <- map["features"]
        certificate <- map["certificate"]
        practicing <- map["practicing"]
        background <- map["background"]
        family <- map["family"]
    }
}




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
    var info2: usermanageInfoModel_info2 = usermanageInfoModel_info2()
    var info3: usermanageInfoModel_info3 = usermanageInfoModel_info3()
    var info4: [usermanageInfoModel_info4] = []
    var info5: usermanageInfoModel_info5 = usermanageInfoModel_info5()
    var info6: [usermanageInfoModel_info6] = []
    var info7: [usermanageInfoModel_info7] = []

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
