//
//  Api.swift
//  huicheng
//
//  Created by lvxin on 2018/2/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import Foundation
let base_api = "http://47.94.108.111:18000/api/"
let base_imageOrFile_api = "http://47.94.108.111:18000"

//------------------------登陆
let login_api = "base/login?"


//------------------------消息

/// 待办通知 列表获取
let noticelist_api = "message/noticelist?"

/// 公告列表 列表获取
let newslist_api = "message/newslist?"

/// 详情
let newsdetial_api = "message/newsdetial?"

//-----------------------个人信息
let user_getinfo_api = "uc/user_getinfo?"
//发票申请 获取列表
let invoice_getlist = "uc/invoice_getlist?"
//报销申请 获取列表
let expense_getlist = "uc/expense_getlist?"
//申请报销
let expense_save_api = "uc/expense_save?"
//获取详情
let expense_getinfo_api = "uc/expense_getinfo?"
//获取报销类型列表
let expense_gettype_api = "uc/expense_gettype?"
//我的收款 获取列表
let finance_getlist_api = "uc/finance_getlist?"
//查看详情
let finance_getinfo_api = "uc/finance_getinfo?"




/// 备忘录列表
let memo_getlist_api = "uc/memo_getlist?"
let memo_getinfo_api = "uc/memo_getinfo?"
let memo_save_api = "uc/memo_save?"
let memo_del_api = "uc/memo_del?"



