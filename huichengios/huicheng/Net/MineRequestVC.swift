//
//  MineRequestVC.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//  我的网络

import UIKit
import ObjectMapper
enum MineRequestVC_enum {
    case user_getinfo,
         invoice_getlist,invoice_getinfo,invoice_gettype,
         memo_getlist,memo_getinfo,memo_save,memo_del,
         expense_save,expense_getinfo,expense_gettype,
         finance_getlist,finance_getinfo,
         work_getlist,work_getinfo,work_save
}

protocol MineRequestVCDelegate {
    func requestSucceed(data : Any) -> Void
    func requestFail() -> Void
    
}

class MineRequestVC: UIViewController, BaseNetViewControllerDelegate {
    var delegate :MineRequestVCDelegate!
    let request : BaseNetViewController = BaseNetViewController()
    var type : MineRequestVC_enum!
    // MARK: 个人信息
    /// 读取基本信息
    func user_getinfoRequest() {
        request.delegate = self
        type = .user_getinfo
        let url =   user_getinfo_api + "k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }
    // MARK: 报销申请
    ///  报销申请 获取列表
    func expense_getlistRequest(p : Int, c: Int) {
        let url =   expense_getlist + "c=\(c)&p=\(p)&k=\(UserInfoLoaclManger.getKey())"
        request.delegate = self
        type = .invoice_getlist
        request.request_api(url: url)
    }
    
    /// 申请报销
    ///
    /// - Parameters:
    ///   - t: 报销类型 int 型
    ///   - n: 单据数量 int 型
    ///   - m: 报销金额
    func expense_saveRequest(t : Int, n: Int ,m:Int) {
        let url =   expense_save_api + "t=\(t)&n=\(n)&m=\(m)&k=\(UserInfoLoaclManger.getKey())"
        request.delegate = self
        type = .expense_save
        request.request_api(url: url)
    }

    
    /// 获取详情
    ///
    /// - Parameter id: <#id description#>
    func expense_getinfoRequest(id : Int) {
        let url =   expense_getinfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.delegate = self
        type = .expense_getinfo
        request.request_api(url: url)
    }
    
    /// 获取报销类型列表
    func expense_gettypeRequest() {
        let url =   expense_gettype_api + "k=\(UserInfoLoaclManger.getKey())"
        request.delegate = self
        type = .expense_gettype
        request.request_api(url: url)
    }


    
    // MARK: 发票申请
    ///  发票申请 获取列表
    func invoice_getlistRequest(p : Int, c: Int) {
        let url =   invoice_getlist_api + "c=\(c)&p=\(p)&k=\(UserInfoLoaclManger.getKey())"
        request.delegate = self
        type = .invoice_getlist
        request.request_api(url: url)
    }
    
    /// 详情
    ///
    /// - Parameter id: <#id description#>
    func invoice_getinfoRequest(id : Int) {
        let url =   invoice_getinfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.delegate = self
        type = .invoice_getinfo
        request.request_api(url: url)
    }
   
    ///  获取发票内容列表
    func invoice_gettypeRequest() {
        let url =   invoice_gettype_api + "k=\(UserInfoLoaclManger.getKey())"
        request.delegate = self
        type = .invoice_gettype
        request.request_api(url: url)
    }


    
    
    // MARK: 备忘录
    
    /// 备忘录 调取列表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    func memo_getlistRequest(p:Int,c:Int = 8) {
        request.delegate = self
        type = .memo_getlist
        let url =   memo_getlist_api + "c=\(c)&p=\(p)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    
    /// 备忘录 调取详情
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    func memo_getinfoRequest(id:Int) {
        request.delegate = self
        type = .memo_getinfo
        let url =   memo_getinfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    

    
    
    /// 新建备忘录
    ///
    /// - Parameters:
    ///   - n: 提醒内容
    ///   - t: 提醒时间;yyyy-MM-dd HH:mm:ss
    ///   - i: 是否提醒;0 或 1
    ///   - id: 修改内容的 ID 大于0就是修改 没有就是新建
    func memo_saveRequest(n:String,t:String,i:Int,id : Int = 0) {
        request.delegate = self
        type = .memo_save
         var url = ""
        if id > 0 {
            url = memo_save_api + "k=\(UserInfoLoaclManger.getKey())&n=\(n)&t=\(t)&i=\(i)&id=\(id)"
        } else {
            url = memo_save_api + "k=\(UserInfoLoaclManger.getKey())&n=\(n)&t=\(t)&i=\(i)"
        }
       
        request.request_api(url: url)
    }
    
    /// 删除备忘录
    ///
    /// - Parameter id: id
    func memo_delRequest(id : Int) {
        request.delegate = self
        type = .memo_del
        let url =   memo_del_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    // MARK: 我的收款
    //列表
    func finance_getlistRequest() {
        request.delegate = self
        type = .finance_getlist
        let url =   finance_getlist_api + "k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    //详情
    func finance_getinfoRequest(id:Int) {
        request.delegate = self
        type = .finance_getinfo
        let url =   finance_getinfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    // MARK: 工作日志
    //获取列表
    func work_getlistRequest() {
        request.delegate = self
        type = .work_getlist
        let url =   work_getlist_api + "k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    //查看详情
    func work_getinfoRequest(id:Int) {
        request.delegate = self
        type = .work_getinfo
        let url =   work_getinfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    
    /// 新建日志
    ///
    /// - Parameters:
    ///   - t: 标题
    ///   - n: 内容
    ///   - a: 附件
    func work_save_apiRequest(t:String,n:String,a:String) {
        request.delegate = self
        type = .work_save
        let url =   work_save_api + "t=\(t)&n=\(n)&a=\(a)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    
    

    // MARK: 网络数据代理
    func requestSucceed(response: Any) {
        if type == .user_getinfo {
            let model = Mapper<user_getinfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed(data: model)
            }
        } else if type == .invoice_getlist{
            let arr = Mapper<expense_getlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed(data: arr)
            }
        } else if type == .memo_getlist {
            let arr = Mapper<memo_getlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed(data: arr)
            }
        }else if type == .memo_getinfo {
            let model = Mapper<memo_getinfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed(data: model)
            }
        } else if (type == .memo_save) || (type == .memo_del) || (type == .expense_save){
            let model = Mapper<CodeData>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed(data: model)
            }
        } else if type == .expense_getinfo{
            //报销详情
        } else if type == .expense_gettype{
            //获取报销类型列表
        } else if type == .invoice_getinfo{
            //发票详情
            
            
        }
    }
    func requestFail(response: Any) {
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
