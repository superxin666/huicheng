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
let sendcode_api = "base/sendcode?"
let mobilelogin_api = "base/mobilelogin?"


//------------------------消息

/// 待办通知 列表获取
let noticelist_api = "message/noticelist?"

/// 公告列表 列表获取
let newslist_api = "message/newslist?"

/// 详情
let newsdetial_api = "message/newsdetial?"

/// 公告管理 获取列表
let newslist1_api = "message/newslist1?"
///  发布/编辑公告
let save_api = "message/save?"
/// 获取接收对象
let getobjectlist_api = "message/getobjectlist?"
/// 发布/撤销公告
let newspublic_api = "message/newspublic?"
/// 删除公告
let del_api = "message/del?"

//-----------------------个人信息
let user_getinfo_api = "uc/user_getinfo?"

/// 修改密码
let user_editpass_api = "uc/user_editpass?"
///-----------------------工作

/// 利益冲突检查
let checkcase_api = "case/checkcase?"



//-----------------------法庭信息管理
let quick_getlist_api = "quick/getlist?"


//-----------------------发票申请 获取列表
let invoice_getlist_api = "uc/invoice_getlist?"
let invoice_getinfo_api = "uc/invoice_getinfo?"
let invoice_gettype_api = "uc/invoice_gettype?"

//-----------------------报销申请 获取列表
let expense_getlist_api = "uc/expense_getlist?"
//申请报销
let expense_save_api = "uc/expense_save?"
//获取详情
let expense_getinfo_api = "uc/expense_getinfo?"
//获取报销类型列表
let expense_gettype_api = "uc/expense_gettype?"

//------------------------我的收款 获取列表
let finance_getlist_api = "uc/finance_getlist?"
//查看详情
let finance_getinfo_api = "uc/finance_getinfo?"

//------------------------工作日志  获取列表
let work_getlist_api = "uc/work_getlist?"
let work_getinfo_api = "uc/work_getinfo?"
let work_save_api = "uc/work_save?"



/// ----------------------备忘录列表
let memo_getlist_api = "uc/memo_getlist?"
let memo_getinfo_api = "uc/memo_getinfo?"
let memo_save_api = "uc/memo_save?"
let memo_del_api = "uc/memo_del?"



