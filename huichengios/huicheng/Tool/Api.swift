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

//------------------------友盟
let umemgKey = "5a8242c1a40fa3399900089a"
let umemgSecret = "yr1dleqjikrndhntlggbzoygfc1enpiq"


//------------------------登陆
let login_api = "base/login?"
let sendcode_api = "base/sendcode?"
let mobilelogin_api = "base/mobilelogin?"
//------------------------基础信息调用
/// 分所列表
let branch_api = "base/branch?"
/// 部门列表
let department_api = "base/department?"
/// 本所律师列表
let userlist_api = "base/userlist?"
/// 案件类型
let casetype_api = "base/casetype?"

/// 上传文件
let uploadfile_api = "base/uploadfile?"


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
//----------------------- 案件管理
///  获取列表

let case_getlist_api = "case/getlist?"

/// 保存  修改
let case_save_api = "case/save?"

/// 获取详情
let case_getinfo_api = "case/getinfo?"

/// 删除
let case_del_api = "case/del?"

/// 生成合同
let case_createdeals_api = "case/createdeals?"
//-----------------------个人信息
let user_getinfo_api = "uc/user_getinfo?"

/// 修改密码
let user_editpass_api = "uc/user_editpass?"

/// -----------------------会议室
let room_getlist_api = "room/getlist?"

let room_save_api = "room/save?"
let room_del_api = "room/del?"
/// 利益冲突检查
let checkcase_api = "case/checkcase?"

/// /-----------------------合同

/// 列表
let deal_getlist_api = "deal/getlist?"

/// 详情
let deal_getinfo_api = "deal/getinfo?"

/// 申请结案
let deal_oversave_api = "deal/oversave?"

/// 删除
let deal_del_api = "deal/del?"

/// /----------------------- 函件管理
let doc_getlist_api = "doc/doc_getlist?"
let doc_getinfo_api = "doc/doc_getinfo?"
let doc_del_api = "doc/doc_del?"
let doc_crt_dealslist_api = "doc/crt_dealslist?"
let doc_crt_choose_api = "doc/crt_choose?"
let doc_crt_getinfo_api = "doc/crt_getinfo?"
let doc_crt_save_api = "doc/crt_save?"

/// /----------------------- 发票审批
let invoice_applylist_api = "finance/invoice_applylist?"
let invoice_applysave_api = "finance/invoice_applysave?"
let invoice_invoice_del_api = "finance/invoice_del?"




/// /----------------------- 银行信息
let bank_getlist_api = "finance/bank_getlist?"
let bank_getinfo_api = "finance/bank_getinfo?"
let bank_save_api = "finance/bank_save?"
/// /----------------------- 报销审批
let expense_applylist_api = "finance/expense_applylist?"
let expense_applysavee_api = "finance/expense_applysave?"
let expense_del_api = "finance/expense_del?"
/// 合同审核 获取列表
let deal_getapplylist_api = "deal/getapplylist?"
let deal_applysave_api = "deal/applysave?"
let deal_searchlist_api = "deal/searchlist?"
/// 结案审核 获取列表
let deal_getoverlist_api = "deal/getoverlist?"
let deal_getoverinfo_api = "deal/getoverinfo?"
let deal_checkoversave_api = "deal/checkoversave?"

/// /-----------------------收款登记
/// 获取列表
let finance_income_getlist_api = "finance/income_getlist?"
/// 获取详情
let finance_income_getinfo_api = "finance/income_getinfo?"
///新增收款-获取合同列表
let finance_income_getdeals_api = "finance/income_getdeals?"
/// 新增收款-获取合同详情
let finance_income_getdealsinfo_api = "finance/income_getdealsinfo?"
/// 新增收款-保存收款信息为草稿
let finance_income_save_api = "finance/income_save?"
//let finance_income_save_api = "finance/income_save?"
///  删除收款信息
let finance_income_del_api = "finance/income_del?"
///  增加收款明细信息
let finance_income_additem_api = "finance/income_additem?"
///  删除收款明细信息
let finance_income_delitem_api = "finance/income_delitem?"
/// /-----------------------签章

/// 函件审核  获取列表
let doc_applylistapi = "doc/doc_applylist?"

/// 函件查询 获取列表
let doc_searchapi = "doc/doc_search?"

/// 函件管理 获取函件列表
let doc_getlistapi = "doc/doc_getlist?"
let doc_applysave_api = "doc/doc_applysave?"


/// /-----------------------模板共享

/// 获取列表
let share_getlist_api = "share/getlist?"
///  获取我的模板列表
let share_getmylist_api = "share/getmylist?"
let share_getinfo_api = "share/getinfo?"
let share_sharegetreply_api = "share/getreply?"
let share_replysave_api = "share/replysave?"
let share_gettype_api = "share/gettype?"
let share_save_api = "share/save?"
//-----------------------法庭信息管理
let quick_getlist_api = "quick/getlist?"


//-----------------------发票申请 获取列表
let invoice_getlist_api = "uc/invoice_getlist?"
let invoice_getinfo_api = "uc/invoice_getinfo?"
let invoice_gettype_api = "uc/invoice_gettype?"
let invoice_save_api = "uc/invoice_save?"
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


//------------文件本地地址
let documentPaths : String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
let filePath = documentPaths + "/filesDocument"
let filePath_downLoad = documentPaths + "/downLoadfilesDocument"
