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
         invoice_getlist,invoice_getinfo,invoice_gettype,invoice_save,//发票
         memo_getlist,memo_getinfo,memo_save,memo_del,//备忘录
         expense_save,expense_getinfo,expense_gettype,expense_getlist,//报销
         finance_getlist,finance_getinfo,
         work_getlist,work_getinfo,work_save,user_editpass//工作日志
}

protocol MineRequestVCDelegate {
    func requestSucceed_mine(data : Any,type : MineRequestVC_enum) -> Void
    func requestFail_mine() -> Void
    
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
    /// 修改密码
    ///
    /// - Parameters:
    ///   - op: 旧密码
    ///   - np: 新密码
    func resetKey(op:String,np : String)  {
        request.delegate = self
        type = .user_editpass
        let url =   user_editpass_api + "op=\(op)&np=\(np)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

        
    }
    // MARK: 报销申请
    
    /// 报销申请 获取列表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - s: 状态 0-未审核;1-已审核;2-审核驳回;3-已支付
    func expense_getlistRequest(p : Int, c: Int, s:String) {
        let url =   expense_getlist_api + "c=\(c)&p=\(p)&s=\(s)&k=\(UserInfoLoaclManger.getKey())"
        request.delegate = self
        type = .expense_getlist
        request.request_api(url: url)
    }
    
    /// 申请报销
    ///
    /// - Parameters:
    ///   - t: 报销类型 int 型
    ///   - n: 单据数量 int 型
    ///   - m: 报销金额
    func expense_saveRequest(id : String ,t : String, n: String ,m:String) {
        let url =   expense_save_api + "id=\(id)&t=\(t)&n=\(n)&m=\(m)&k=\(UserInfoLoaclManger.getKey())"
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
        request.request_api(url: url,type: .alltyper)
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
    func invoice_getlistRequest(p : Int, c: Int ,s : String) {
        let url =   invoice_getlist_api + "s=\(s)&c=\(c)&p=\(p)&k=\(UserInfoLoaclManger.getKey())"
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


    func invoice_saveRequest(typeStr:String,title:String,money:String,creditcode:String,sendtype:String,content:String,isbooks:String,applytime:String,identifier:String,eaddr:String,ephone:String,ebank:String,ecard:String,name:String,phone:String,zip:String,addr:String,paytype:String,mtime:String,remark:String)  {

        if !(title.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入标题")
            return
        }

        if !(creditcode.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入信用代码")
            return
        }
        if !(content.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入发票内容")
            return
        }
        if !(money.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入发票金额")
            return
        }

        if isbooks == "1" {
            if !(applytime.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入入账时间")
                return
            }
        }
        if sendtype == "0" {
            if !(mtime.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入上门自取时间")
                return
            }
        } else {
            if !(name.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入收件人")
                return
            }
            if !(phone.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入联系电话")
                return
            }
            if !(zip.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入邮编")
                return
            }
            if !(addr.count > 0) {
                SVPMessageShow.showErro(infoStr: "请输入邮寄地址")
                return
            }
        }




        let titleStr :String = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let creditcodeStr :String = creditcode.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let contentStr :String = content.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let applytimeStr :String = applytime.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let mtimeStr :String = mtime.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let nameStr :String = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let phoneStr :String = phone.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let zipStr :String = zip.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let addrStr :String = mtime.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let remarkStr :String = remark.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        let url =   invoice_save_api + "type=\(typeStr)&title=\(titleStr)&money=\(money)&creditcode=\(creditcodeStr)&sendtype=\(sendtype)&content=\(contentStr)&isbooks=\(isbooks)&applytime=\(applytimeStr)&identifier=\(identifier)&eaddr=\(eaddr)&ephone=\(ephone)&ebank=\(ebank)&name=\(nameStr)&phone=\(phoneStr)&zip=\(zipStr)&addr=\(addrStr)&paytype=\(paytype)&mtime=\(mtimeStr)&remark=\(remarkStr)&k=\(UserInfoLoaclManger.getKey())"
        request.delegate = self
        type = .invoice_save
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
        let tStr :String = t.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let nStr :String = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
         var url = ""
        if id > 0 {
            url = memo_save_api + "k=\(UserInfoLoaclManger.getKey())&n=\(nStr)&t=\(tStr)&i=\(i)&id=\(id)"
        } else {
            url = memo_save_api + "k=\(UserInfoLoaclManger.getKey())&n=\(nStr)&t=\(tStr)&i=\(i)"
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
    func finance_getlistRequest(p:Int,c:Int,no:String,n:String,s:String,st:String,et:String) {
        request.delegate = self
        type = .finance_getlist
        let url =   finance_getlist_api + "p=\(p)&c=\(c)&no=\(no)&n=\(n)&s=\(s)&st=\(st)&et=\(et)&k=\(UserInfoLoaclManger.getKey())"
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
    func work_getlistRequest(p : Int, c: Int) {
        request.delegate = self
        type = .work_getlist
        let url =   work_getlist_api + "c=\(c)&p=\(p)&k=\(UserInfoLoaclManger.getKey())"
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
        let tStr = t.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url =   work_save_api + "t=\(tStr)&n=\(nStr)&a=\(a)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    
    

    // MARK: 网络数据代理
    func requestSucceed(response: Any) {
        if type == .user_getinfo {
            let model = Mapper<user_getinfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_mine(data: model,type : .user_getinfo)
            }
        }  else if type == .memo_getlist {
            //备忘录 列表
            HCLog(message: "备忘录请求成功")

            let arr = Mapper<memo_getlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_mine(data: arr,type : .memo_getlist)
            }
        }else if type == .memo_getinfo {
            //备忘录 详情
            let model = Mapper<memo_getinfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_mine(data: model,type : .memo_getinfo)
            }
        } else if (type == .memo_save) || (type == .memo_del) || (type == .expense_save) || (type == .user_editpass) || (type == .invoice_save || type == .work_save){
            let model = Mapper<CodeData>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_mine(data: model,type : type)
            }
        } else if type == .expense_getinfo{
            //报销详情
            let model = Mapper<expense_getinfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_mine(data: model,type : type)
            }

            
        } else if type == .expense_getlist{
            //报销列表
            let arr = Mapper<expense_getlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_mine(data: arr,type : type)
            }
            
        } else if type == .expense_gettype{
            //获取报销类型列表
            let arr = Mapper<expense_gettypeModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_mine(data: arr,type : type)
            }
        } else if type == .invoice_getlist{
            //发票列表
            HCLog(message: "发票列表请求成功")
            let arr = Mapper<invoice_getlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_mine(data: arr,type : type)
            }
            
        }  else if type == .work_getlist{
            //工作日志 列表
            let arr = Mapper<work_getlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_mine(data: arr,type : type)
            }

        }else if type == .work_getinfo{
            //工作日志 详情
            let model = Mapper<work_getinfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_mine(data: model,type : type)
            }

        } else if type == .finance_getlist{
            //我的收入
            let arr = Mapper<finance_getlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_mine(data: arr,type : type)
            }

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
