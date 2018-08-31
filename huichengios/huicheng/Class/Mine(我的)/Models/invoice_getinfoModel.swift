//
//  invoice_getinfoModel.swift
//  huicheng
//
//  Created by lvxin on 2018/3/20.
//  Copyright © 2018年 lvxin. All rights reserved.
// 发票 获取详情
//"id": 296,//ID
//"type": 1, //发票类型 //0-增值税普通发票;1-增值税专用发票
//"typeStr": "增值税专用发票",//发票类型显示文字
//"title": "深圳市 XXXX 有限公司",//发票抬头
//"money": 10000, //发票金额
//"sendtype": 0, //寄送方式 0-上门自取;1-快递邮寄 "sendtypeStr": "上门自取",//寄送方式显示文字
//"addtime": "2017-08-11 16:50:41",//申请时间
//"state": 3, //状态 0-未审核;1-已审核;2-审核驳回;3-已寄出
//"stateStr": "已寄出",//状态显示文字


//"note": "",//审核信息
//"content": "民事代理费",//发票内容
//"isbooks": 1, //是否入帐 0-未入帐;1-已入帐
//"isbooksStr": "已入帐",//是否入帐显示文字
//"mtime": "2017-08-16 00:00:00",//收件时间或上门自取时间 "identifier": "91440300335061905X",//纳税人识别号
//"eaddr": "深圳市南山区沙河街道 XXXX 号",//专用发票_地址 "ephone": " 86282977",//专用发票_电话
//"ebank": "中国银行股份有限公司深圳深圳湾支行",//专用发票_银行 "ecard": "766545199927",//专用发票_帐号
//"eimg1": "",//税务登记证
//"eimg2": "",//组织机构代码(副本)
//"eimg3": "",//开户许可证
//"eimg4": "",//营业执照(副本)
//"eimg5": "",//一般纳税人资格认定书
//"name": "",//快递-收件人
//"phone": "",//快递-电话
//"zip": "",//快递-邮编
//"addr": "",//快递-收货地址
//"paytype": 0, //邮寄付费方式:0-收件人付费;1-律师账扣; "paytypeStr": "收件人付费",//邮寄付费方式显示文字
//"remark": "",//备注信息
//"admin": "么华颖",//审核人
//"applytime": "2017-03-24 16:46:22"//审核时间
//},

import UIKit
import ObjectMapper

class invoice_getinfoModel: Mappable {
    var id: Int!
    var type: Int!
    var typeStr: String!
    var title: String!
    var money: Int!
    var sendtype: Int!
    var sendtypeStr: String!
    var identifier: String!
    var creditcode: String!



    var addtime: String!
    var state: Int!
    var stateStr: String!
    var note: String!
    var content: String!
    
    var isbooks: Int!
    var isbooksStr: String!
    var mtime: String!
    var eaddr: String!
    var ebank: String!
    var ephone: String!
    var ecard: String!


    var eimg1: String!
    var eimg2: String!
    var eimg3: String!
    var eimg4: String!
    var eimg5: String!
    var name: String!
    var phone: String!
    var zip: String!
    var addr: String!
    var paytype: Int = 0

    var paytypeStr: String!
    var remark: String!
    var admin: String!
    var applytime: String!
    
    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        typeStr <- map["typeStr"]
        title <- map["title"]
        money <- map["money"]
        identifier <- map["identifier"]
        creditcode <- map["creditcode"]
        ephone <- map["ephone"]
        ecard <- map["ecard"]

        sendtype <- map["sendtype"]
        sendtypeStr <- map["sendtypeStr"]
        addtime <- map["addtime"]
        state <- map["state"]
        stateStr <- map["stateStr"]
        note <- map["note"]
        content  <- map["content"]
        isbooks  <- map["isbooks"]
        isbooksStr  <- map["isbooksStr"]
        mtime  <- map["mtime"]
        eaddr  <- map["eaddr"]
        ebank  <- map["ebank"]
        eimg1  <- map["eimg1"]
        eimg2  <- map["eimg2"]
        eimg3  <- map["eimg3"]
        eimg4  <- map["eimg4"]
        eimg5  <- map["eimg5"]
        name  <- map["name"]
        phone  <- map["phone"]
        zip  <- map["zip"]
        addr  <- map["addr"]
        paytype  <- map["paytype"]
        paytypeStr <- map["paytypeStr"]
        remark  <- map["remark"]
        admin  <- map["admin"]
        applytime  <- map["applytime"]
        

        
    }
}
