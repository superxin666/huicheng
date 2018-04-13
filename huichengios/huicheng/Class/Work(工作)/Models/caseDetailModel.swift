//
//  caseDetailModel.swift
//  huicheng
//
//  Created by lvxin on 2018/4/13.
//  Copyright © 2018年 lvxin. All rights reserved.
//
//"id": 2660, //ID
//"type": 1, //案件类型
//"typeStr": "诉讼案件",//案件类型显示文字 "casenum": "AJYB20170005",//案件编号
//"n": "XX 物业诉谢 XX 物业服务合同纠纷",//案件名称 "rt": "2017-12-26 00:00:00",//立案日期
//"pn": "宜宾 XX 物业管理有限公司",//委托方-委托人 "pc": "王 XX",//委托方-联系人
//"pp": "18912345677",//委托方-电话
//"pz": "644000",//委托方-邮编
//"pj": "副经理",//委托方-职务
//"pd": "",//委托方-身份证号
//"pa": "宜宾市翠屏区 XX 路 16 号",//委托方-联系地址 "on": "",//对方当事方-委托人
//"oc": "",//对方当事方-联系人
//"op": "",//对方当事方-电话
//"oz": "",//对方当事方-邮编
//"oj": "",//对方当事方-职务
//"oa": "",//对方当事方-联系地址
//"r": 714, //立案律师 ID
//"rStr": "李健",//立案律师显示名称
//"d": 59, //案件组别 ID
//"dStr": "案件组",//案件组别显示文字
//"w1": 714, //承办律师 ID
//"w1Str": "李健",//承办律师显示文字
//
//"w2": 714, //承办律师 ID
//"w2Str": "李健",//承办律师显示文字
//"ct": "委托人追索拖欠的物业费",//案件自述 "sj": "106000",//标的
//"addtime": "2017-12-26 10:56:34"//添加时间
import UIKit
import ObjectMapper

class caseDetailModel: Mappable {
    var id: Int!
    var type: Int!
    var typeStr: String!
    var casenum: String!
    var n: String!
    var rt: String!
    var pn: String!
    var pc: String!
    var pp: String!
    var pz: String!
    var pj: String!

    var pd: String!
    var pa: String!

    var on: String!
    var oc: String!
    var op: String!
    var oz: String!
    var oj: String!
    var oa: String!
    var r: Int!
    var rStr: String!
    var d: Int!
    var dStr: String!
    var w1: Int!
    var w1Str: String!
    var w2: Int!
    var w2Str: String!
    var ct: String!
    var sj: String!
    var addtime: String!
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        typeStr <- map["typeStr"]
        casenum <- map["casenum"]
        n <- map["n"]
        rt <- map["rt"]
        pn <- map["pn"]
        pc <- map["pc"]
        pp <- map["pp"]
        pz <- map["pz"]
        pj <- map["pj"]
        pd <- map["pd"]
        pa <- map["pa"]
        on <- map["on"]
        oc <- map["oc"]
        op <- map["op"]
        oz <- map["oz"]
        oj <- map["oj"]
        oa <- map["oa"]
        r <- map["r"]
        rStr <- map["rStr"]
        d <- map["d"]
        dStr <- map["dStr"]
        w1 <- map["w1"]
        w1Str <- map["w1Str"]
        w2 <- map["w2"]
        w2Str <- map["w2Str"]
        ct <- map["ct"]
        sj <- map["sj"]
        addtime <- map["addtime"]
    }
}

class caseDetailModelMap: Mappable {
    var data: caseDetailModel!
    var departments: [departmentModel] = []
    var users: [userlistModel] = []


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        data <- map["data"]
        departments <- map["departments"]
        users <- map["users"]
    }
}
