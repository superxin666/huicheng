//
//  WorkRequestVC.swift
//  huicheng
//
//  Created by lvxin on 2018/4/1.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper
enum WorkRequestVC_enum {
    //
    case checkcase,//利益冲突检查
         save,newslist1,getobjectlist,newspublic,del,//公告  发布/编辑公告  获取列表  获取接收对象  发布/撤销公告  删除
         case_getlist,case_getinfo,case_add,casedel,//案件列表  获取案件详情  添加案件  删除
         branch,department,userlist,casetype,//分所列表  部门列表  本所律师列表  案件类型
         deal,getinfo,oversave,dealdel,//合同列表 详情  申请结案  删除合同
         room,roomsave,roomdel,//会议室
         dealgetapplylist,applysave,searchlist,// 合同审核  获取列表
         dealgetoverlist,dealgetoverinfo,checkoversave,//结案审核
         invoice_applylist,invoice_applysave,invoice_del,invoice_getinfo,//发票审批
         expense_applylist,expense_applysave,expense_del,//报销审批
         sharegetlist,sharegetmylist,sharegetinfo,sharegetreply,sharereplysave,sharegettype,sharesave,//模板共享 获取列表
         bank_getlist,bank_getinfo,bank_save//银行信息
}

protocol WorkRequestVCDelegate : NSObjectProtocol{
    //
    func requestSucceed_work(data:Any,type : WorkRequestVC_enum) -> Void
    func requestFail_work() -> Void
    
}

class WorkRequestVC: UIViewController,BaseNetViewControllerDelegate {
    var delegate :WorkRequestVCDelegate!
    let request : BaseNetViewController = BaseNetViewController()
    var type : WorkRequestVC_enum!


    // MARK: 基础信息调用
    func branchRequest() {
        request.delegate = self
        type = .branch
        let url =   branch_api + "k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }



    /// 部门列表
    func departmentRequest()  {
        request.delegate = self
        type = .department
        let url =   department_api + "k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    /// 本所律师列表
    func userlistRequest() {
        request.delegate = self
        type = .userlist
        let url =   userlist_api + "k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    /// 案件类型
    func casetypeRequest() {
        request.delegate = self
        type = .casetype
        let url =   casetype_api + "k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    // MARK: 利益冲突检查
    /// 利益冲突检查
    ///
    /// - Parameters:
    ///   - n: 关系人
    ///   - i: 关系人身份证号 (关系人或者关系人身份证号二选一必填)
    func checkcaseRequest(n:String,i:String) {
        request.delegate = self
        type = .checkcase
        let url =   checkcase_api + "n=\(n)&i=\(i)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    
    
    
    // MARK: 公告管理
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - p: 当前页码
    ///   - c: 每页显示条数
    ///   - bid: 分所 ID，INT 型，可不传
    ///   - t: 标题
    ///   - b: 发布时间段-开始
    ///   - e: 发布时间段-结束
    ///   - u: 发布者
    func newslist1Request(p:Int,c:Int,bid:Int,t:String,b:String,e:String,u:String) {
        request.delegate = self
        type = .newslist1
        var tStr = ""
        if t.count > 0 {
            tStr = t.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var uStr = ""
        if u.count > 0 {
            uStr = u.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var bStr = ""
        if b.count > 0 {
            bStr = b.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var eStr = ""
        if e.count > 0 {
            eStr = b.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        let url =   newslist1_api + "p=\(p)&c=\(c)&t=\(tStr)&b=\(bStr)&e=\(eStr)&u=\(uStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    
    
    /// 获取接收对象
    func getobjectlistRequest() {
        request.delegate = self
        type = .getobjectlist
        let url =   getobjectlist_api + "k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - id: 添加信息时可不值，编辑信息时必传;
    ///   - t: 标题
    ///   - n: 内容，支持富文本
    ///   - o: 接收对象，INT 型
    ///   - s: 状态，INT 型 0-未发布;1-已发布
    ///   - d: 是否发送短信，INT 型 返回值
    func saveRequest(id:String,t:String,n:String,o:String,s:Int,d:Int,f:String) {
        request.delegate = self
        type = .save
        let tStr : String = t.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let nStr : String = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let fStr : String = f.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url =   save_api + "t=\(tStr)&n=\(nStr)&o=\(o)&s=\(s)&d=\(d)&f=\(fStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }
    
    
    
    /// 发布/撤销公告
    ///
    /// - Parameters:
    ///   - id: 公告id
    ///   - s: 1发布 2撤销
    func newspublicRequest(id: Int,s:Int) {
        request.delegate = self
        type = .newspublic
        let url =   newspublic_api + "id=\(id)&s=\(s)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    
    /// 删除消息
    ///
    /// - Parameter id: id
    func delRequest(id: Int) {
        request.delegate = self
        type = .del
        let url =   del_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
     // MARK: 获取案件
    func casegetlistRerquest(p:Int,c:Int,b:String,s:String) {
        request.delegate = self
        type = .case_getlist
        var bStr = ""
        if b.count > 0 {
            bStr = b.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var eStr = ""
        if s.count > 0 {
            eStr = b.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        let url =   case_getlist_api + "p=\(p)&c=\(c)&b=\(bStr)&s=\(eStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }


    /// 案件详情
    ///
    /// - Parameter id: <#id description#>
    func casegetinfoRerquest(id:Int) {
        request.delegate = self
        type = .case_getinfo
        let url =   case_getinfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url,type: .alltyper)
    }


    /// 添加案件
    ///
    /// - Parameters:
    ///   - t: <#t description#>
    ///   - n: <#n description#>
    ///   - rt: <#rt description#>
    ///   - pn: <#pn description#>
    ///   - pc: <#pc description#>
    ///   - pp: <#pp description#>
    ///   - pz: <#pz description#>
    ///   - pj: <#pj description#>
    ///   - pd: <#pd description#>
    ///   - pa: <#pa description#>
    ///   - on: <#on description#>
    ///   - oc: <#oc description#>
    ///   - op: <#op description#>
    ///   - oz: <#oz description#>
    ///   - oj: <#oj description#>
    ///   - oa: <#oa description#>
    ///   - r: <#r description#>
    ///   - d: <#d description#>
    ///   - w1: <#w1 description#>
    ///   - w2: <#w2 description#>
    ///   - ct: <#ct description#>
    ///   - sj: <#sj description#>
    func caseAdd(t:String,n:String,rt:String,pn:String,pc:String,pp:String,pz:String,pj:String,pd:String,pa:String,on:String,oc:String,op:String,oz:String,oj:String,oa:String,r:String,d:String,w1:String,w2:String,ct:String,sj:String,id:String)  {

        let inputArr : Array<String> = [t,n,rt,pn,pc,pp,pz,pj,pd,pa,on,oc,op,oz,oj,oa,r,d,w1,w2,ct,sj,id]
        let nameArr = ["案件类型","案件名称","立案日期","委托方-委托人","委托方-联系人","委托方-电话","委托方-邮编","委托方-职务","委托方-身份证号","委托方-联系地址","对方当事方-委托人","对方当事方-联系人","对方当事方-电话","对方当事方-邮编","对方当事方-职务","对方当事方-联系地址","立案律师","案件组别","承办律师","承办律师","案件自述","标的",""]

        for i in 0..<inputArr.count - 1 {
            let str = inputArr[i]
            if !(str.count > 0) {
                SVPMessageShow.showErro(infoStr: "请您输入"+"\(nameArr[i])")
                return
            }
        }
//        HCLog(message: "1212312321")
        var arr : Array<String> = inputArr.map { (str) -> String in
            str.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        }

        request.delegate = self
        type = .case_add
        let url =   case_save_api + "t=\(arr[0])&n=\(arr[1])&rt=\(arr[2])&pn=\(arr[3])&pc=\(arr[4])&pp=\(arr[5])&pz=\(arr[6])&pj=\(arr[7])&pd=\(arr[8])&pa=\(arr[9])&on=\(arr[10])&oc=\(arr[11])&op=\(arr[12])&oz=\(arr[13])&oj=\(arr[14])&oa=\(arr[15])&r=\(arr[16])&d=\(arr[17])&w1=\(arr[18])&w2=\(arr[19])&ct=\(arr[20])&sj=\(arr[21])&k=\(UserInfoLoaclManger.getKey())&id=\(id)"
        request.request_api(url: url,type: .alltyper)
    }


    /// 删除合同
    ///
    /// - Parameter id: <#id description#>
    func casedelRequest(id : Int) {
        request.delegate = self
        type = . casedel
        let url =   case_del_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }



    // MARK: 合同管理

    /// 列表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - n: <#n description#>
    func dealgetlist(p :Int,c:Int,n:String) {
        request.delegate = self
        type = .deal
        let url =   deal_getlist_api + "p=\(p)&c=\(c)&n=\(n)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    /// 合同详情
    ///
    /// - Parameter id: <#id description#>
    func dealgetinfo(id : Int) {
        request.delegate = self
        type = .getinfo
        let url =   deal_getinfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    /// 申请结案
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - n: <#n description#>
    ///   - t: <#t description#>
    ///   - d: <#d description#>
    ///   - i: <#i description#>
    func dealoversave(id : Int,n:String,t:String,d:String,i:String)  {
        request.delegate = self
        type = .oversave
        var tStr = ""
        if t.count > 0 {
            tStr = t.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var dStr = ""
        if d.count > 0 {
            dStr = d.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        let url =   deal_oversave_api + "id=\(id)&n=\(n)&t=\(tStr)&d=\(dStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }



    /// 合同删除
    ///
    /// - Parameter id: <#id description#>
    func dealdelRequest(id : Int) {
        request.delegate = self
        type = .dealdel
        let url =   deal_del_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    // MARK: 合同审核


    /// 合同审核 获取列表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - n: <#n description#>
    ///   - b: <#b description#>
    ///   - e: <#e description#>
    ///   - u: <#u description#>
    ///   - p: <#p description#>
    func dealgetapplylist(p:Int,c:Int,n:String,b:String,e:String,u:String) {
        request.delegate = self
        type = .dealgetapplylist
        let url = deal_getapplylist_api   + "c=\(c)&p=\(p)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }


    /// 审核保存
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - s: <#s description#>
    ///   - n: <#n description#>
    func applysaveRequest(id:String,s:String,n:String) {
        request.delegate = self
        type = .applysave
        var nStr = ""
        if nStr.count > 0 {
            nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        let url = deal_applysave_api   + "id=\(id)&s=\(s)&n=\(nStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    /// 合同查询
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - n: <#n description#>
    func searchlistReuest(p:Int,c:Int,n:String) {
        request.delegate = self
        type = .searchlist
        var nStr = ""
        if nStr.count > 0 {
            nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        let url = deal_searchlist_api   + "p=\(p)&c=\(c)&n=\(nStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }


    // MARK: 结案审核
    ///   获取列表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - n: <#n description#>
    ///   - b: <#b description#>
    ///   - e: <#e description#>
    ///   - u: <#u description#>
    ///   - pr: <#pr description#>
    func dealgetoverlistRequest(p:Int,c:Int,n:String,b:String,e:String,u:String,pr:String) {
        request.delegate = self
        type = .dealgetoverlist
        let url = deal_getoverlist_api   + "c=\(c)&p=\(p)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }


    /// 获取详情
    ///
    /// - Parameter id: <#id description#>
    func dealgetoverinfoRequest(id:String) {
        request.delegate = self
        type = .dealgetoverinfo
        let url = deal_getoverinfo_api   + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }

    /// 结案确认保存
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - s: <#s description#>
    ///   - n: <#n description#>
    ///   - pn: <#pn description#>
    ///   - rn: <#rn description#>
    func checkoversaveRewuest(id:String,s:String,n:String,pn:String,rn:String) {
        var pnStr = ""
        pnStr = pn.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        var rnStr = ""
        rnStr = rn.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        var nStr = ""
        if n.count > 0 {
            nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }


        request.delegate = self
        type = .checkoversave
        let url = deal_checkoversave_api   + "id=\(id)&s=\(s)&pn=\(pnStr)&n=\(nStr)&rn=\(rnStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }


    // MARK: 函件管理
     // MARK: 银行信息
    func bank_getlistRequest(p:Int,c:Int,u:String,b:String,d:String,n:String) {
        request.delegate = self
        type = .bank_getlist
        let nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        let url = bank_getlist_api   + "p=\(p)&c=\(c)&u=\(u)&b=\(b)&d=\(d)&n=\(nStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    func bank_getinfoRequest(id:Int) {
        request.delegate = self
        type = .bank_getinfo
        let url = bank_getinfo_api   + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    func bank_saveRequest(id:Int,bank:String,name:String,card:String) {

        if !(bank.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入银行名称")
            return
        }
        if !(name.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入开户姓名")
            return
        }
        if !(card.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入卡号")
            return
        }

        request.delegate = self
        type = .bank_save
        let bankStr = bank.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let nameStr = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = bank_save_api   + "id=\(id)&bank=\(bankStr)&name=\(nameStr)&card=\(card)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    // MARK: 发票审批
    /// 列表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - n: <#n description#>
    ///   - u: <#u description#>
    func invoice_applylist(p:Int,c:Int,u:String) {
        request.delegate = self
        type = .invoice_applylist
        let url = invoice_applylist_api   + "p=\(p)&c=\(c)&u=\(u)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    /// 保存
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - s: <#s description#>
    ///   - n: <#n description#>
    func invoice_applysave(id:Int,s:Int,n:String) {
        request.delegate = self
        type = .invoice_applysave
        let sStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        let url = invoice_applysave_api   + "id=\(id)&s=\(sStr)&n=\(n)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }


    /// 获取详情
    ///
    /// - Parameter id: <#id description#>
    func invoice_getinfoRequest(id : Int) {
        request.delegate = self
        type = .invoice_getinfo
        let url = invoice_getinfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }

    /// 删除
    ///
    /// - Parameter id: <#id description#>
    func invoice_del(id:Int) {
        request.delegate = self
        type = .invoice_del
        let url = invoice_invoice_del_api   + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    // MARK: 报销审批
    func expense_applylistReuest(p:Int,c:Int,u:String) {
        request.delegate = self
        type = .expense_applylist
        let url = expense_applylist_api   + "p=\(p)&c=\(c)&u=\(u)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    /// 保存
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - s: <#s description#>
    ///   - n: <#n description#>
    func expense_applysave(id:Int,s:Int,n:String) {
        request.delegate = self
        type = .expense_applysave
        let sStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        let url = expense_applysavee_api  + "id=\(id)&s=\(sStr)&n=\(n)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    /// 删除
    ///
    /// - Parameter id: <#id description#>
    func expense_de(id:Int) {
        request.delegate = self
        type = .expense_del
        let url = expense_del_api   + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }



    // MARK: 会议室
    func roomgetlist(){
        request.delegate = self
        type = .room
        let url = room_getlist_api   + "k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }




    /// 会议室保存
    ///
    /// - Parameters:
    ///   - b: <#b description#>
    ///   - e: <#e description#>
    ///   - t: <#t description#>
    ///   - n: <#n description#>
    func roomsave(b:String,e:String,t:String,n:String) {
        request.delegate = self
        type = .roomsave
        var bStr = ""
        if b.count > 0 {
            bStr = b.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        } else {
            SVPMessageShow.showErro(infoStr: "输入开始时间")
            return
        }
        var eStr = ""
        if e.count > 0 {
            eStr = e.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }else {
            SVPMessageShow.showErro(infoStr: "输入结束时间")
            return
        }
        var nStr = ""
        if n.count > 0 {
            nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        } else {
            SVPMessageShow.showErro(infoStr: "输入备注")
            return
        }

        let url = room_save_api  + "b=\(bStr)&e=\(eStr)&n=\(nStr)&t=\(t)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    /// 删除
    ///
    /// - Parameter id: <#id description#>
    func roomdel(id : Int) {
        request.delegate = self
        type = .roomdel
        let url = room_del_api   + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    // MARK: 模板共享

    /// 获取列表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - t: 0-不限;1-诉讼案件;2-非诉案件;3-刑事案件;4-法律顾问;5-采购合同;6-资质文件;
    ///   - kw: 关键字
    func sharegetlistRequest(p:Int,c:Int,t:String,kw:String) {
        request.delegate = self
        type = .sharegetlist
        let kwStr = kw.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = share_getlist_api   + "p=\(p)&c=\(c)&t=\(t)&kw=\(kwStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }



    /// 我的列表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - t: <#t description#>
    ///   - kw: <#kw description#>
    func sharegetmylistRequest(p:Int,c:Int,t:String,kw:String) {
        request.delegate = self
        type = .sharegetmylist
        let kwStr = kw.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = share_getmylist_api   + "p=\(p)&c=\(c)&t=\(t)&kw=\(kwStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }


    /// 获取详情-正文
    ///
    /// - Parameter id: <#id description#>
    func sharegetinfoRequest(id:Int) {
        request.delegate = self
        type = .sharegetinfo
        let url = share_getinfo_api   + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }


    /// 获取详情-回复
    ///
    /// - Parameter id: <#id description#>
    func sharegetreplyRequest(id:Int) {
        request.delegate = self
        type = .sharegetreply
        let url = share_sharegetreply_api   + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    /// 提交回复
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - n: <#n description#>
    func sharereplysaveRequest(id:Int,n:String) {
        if !(n.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入回复内容")
            return
        }
        request.delegate = self
        type = .sharereplysave
        let nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = share_replysave_api   + "id=\(id)&n=\(nStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    /// 新建
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - n: <#n description#>
    ///   - t: <#t description#>
    ///   - d: <#d description#>
    ///   - f: <#f description#>
    func sharesavequest(id:String,n:String,t:String,d:String,f:String) {
        request.delegate = self
        type = .sharesave
        let nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let tStr = t.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let fStr = f.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        var url  = ""

        if id.count > 0 {
             url = share_save_api   + "id=\(id)&n=\(nStr)&t=\(tStr)&d=\(d)&f=\(fStr)&k=\(UserInfoLoaclManger.getKey())"


        } else {
             url = share_save_api   + "n=\(nStr)&t=\(tStr)&d=\(d)&f=\(fStr)&k=\(UserInfoLoaclManger.getKey())"

        }
        request.request_api(url: url)
    }



    /// 获取分类信息
    func sharegettypeRequest() {
        request.delegate = self
        type = .sharegettype
        let url = share_gettype_api   + "k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }



    func requestSucceed(response: Any) {
        if type == .checkcase || type == .case_getlist {
            //利益冲突检查
            let arr = Mapper<checkcaseModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }
        } else if type == .case_getinfo{
            //案情详情
            let model = Mapper<caseDetailModelMap>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: model,type : type)
            }

        }
        else if type == .newslist1{
            //公告  获取列表
            let arr = Mapper<newslist1Model>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }
            
        } else if type == .getobjectlist{
            //获取接收对象
            let arr = Mapper<getobjectlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }
        } else if type == .save || type == .newspublic || type == .oversave || type == .casedel || type == .dealdel || type == .roomsave || type == .roomdel || type == .applysave || type == .checkoversave  || type == .invoice_applysave || type == .invoice_del || type == .expense_applysave || type == .expense_del ||  type == .bank_save || type == .sharereplysave{
            //发布公告
            let model = Mapper<CodeData>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: model,type : type)
            }
        } else if type == .department{
            //部门列表
            let arr = Mapper<departmentModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }
        } else if type == .userlist{
            //本所律师列表
            let arr = Mapper<userlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }
        } else if type == .casetype || type == .sharegettype{
            //案件类型 获取分类信息
            let arr = Mapper<casetypeModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }
        } else if type == .branch{
            //分所列表
            let arr = Mapper<branchModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }
        } else if type == .case_add{
            let model = Mapper<CodeData>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: model,type : type)
            }
        } else if type == .deal || type == .dealgetapplylist || type == .dealgetoverlist || type == .searchlist{
            let arr = Mapper<dealGetlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }

        } else if type == .getinfo || type == .dealgetoverinfo{
            let model = Mapper<getinfoDealModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: model,type : type)
            }

        } else if type == .room{
            let arr = Mapper<roomModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }

        } else if type == .sharegetlist || type == .sharegetmylist{
            let arr = Mapper<shareGetlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }
        } else if type == .invoice_applylist{
            let arr = Mapper<invoice_getlistModel>().mapArray(JSONArray: response as! [[String : Any]])

            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }
        } else if type == .expense_applylist{
            let arr = Mapper<expense_getlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }
        } else if type == .bank_getlist{
            let arr = Mapper<bank_getlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }
        } else if type == .bank_getinfo{
            let model = Mapper<bank_getlistModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: model,type : type)
            }
        } else if type == .sharegetinfo{
            let model = Mapper<sharegetinfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: model,type : type)
            }

        } else if type == .sharegetreply{
            let arr = Mapper<sharegetreplyModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
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
