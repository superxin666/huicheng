
//
//  getinfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/4/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

class getinfoDealModel: Mappable {
    var id: Int!
    var dealsnum: String!
    var begintime: String!
    var endtime: String!
    var amount: String!
    var img: String!
    var dealpaylasttime: String!
    var ispaper: Int!
    var ispaperStr : String!
    var paper : String!
    var branch: String!
    var state: Int!


    var stateStr: String!
    var admin: String!
    var applytime: String!
    var note: String!
    var type: Int!
    var typeStr: String!
    var casenum: String!
    var n : String!
    var rt : String!
    var pn: String!
    var pc: String!

    var pp: String!
    var pz: String!
    var pj: String!
    var pd: String!
    var pa: String!
    var on: String!
    var oc: String!
    var op : String!
    var oz : String!
    var oj: String!
    var oa: String!

    var r: String!
    var rStr: String!
    var d: Int!
    var dStr: String!
    var w1 : String!
    var w1Str : String!
    var w2: String!
    var w2Str: String!

    var ct : String!
    var sj: String!
    var addtime: String!


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        dealsnum <- map["dealsnum"]
        begintime <- map["begintime"]
        type <- map["type"]
        endtime <- map["endtime"]
        amount <- map["amount"]
        dealpaylasttime <- map["dealpaylasttime"]
        img <- map["img"]
        ispaper <- map["ispaper"]
        ispaperStr <- map["ispaperStr"]
        paper <- map["paper"]
        branch <- map["branch"]
        dealsnum <- map["dealsnum"]
        state <- map["stateStr"]
        stateStr <- map["type"]
        admin <- map["admin"]
        applytime <- map["applytime"]
        note <- map["note"]
        type <- map["type"]
        typeStr <- map["typeStr"]
        casenum <- map["casenum"]
        n <- map["n"]
        rt <- map["rt"]
        pn <- map["pn"]
        pc <- map["pc"]
        pz <- map["pz"]
        pj <- map["pj"]
        pd <- map["pd"]
        pa <- map["pa"]
        on <- map["on"]
        oc <- map["oc"]
        op <- map["op"]
        oz <- map["oz"]

        oj <- map["oj"]
        oa <- map["ooan"]
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
