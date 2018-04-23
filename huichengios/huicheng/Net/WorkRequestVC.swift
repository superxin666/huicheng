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
         room//会议室
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
    func saveRequest(id:String,t:String,n:String,o:String,s:Int,d:Int) {
        request.delegate = self
        type = .save
        let tStr : String = t.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let nStr : String = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        let url =   save_api + "t=\(tStr)&n=\(nStr)&o=\(o)&s=\(s)&d=\(d)&k=\(UserInfoLoaclManger.getKey())"
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
        let nameArr = ["案件类型","案件名称","立案日期","委托方-委托人","委托方-联系人","委托方-电话","委托方-邮编","委托方-职务","委托方-身份证号","委托方-联系地址","对方当事方-委托人","对方当事方-联系人","对方当事方-电话","对方当事方-邮编","对方当事方-职务","对方当事方-联系地址","立案律师","案件组别","承办律师","承办律师","案件自述","标的"]

        for i in 0..<inputArr.count {
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
        let url =   case_save_api + "t=\(arr[0])&n=\(arr[1])&rt=\(arr[2])&pn=\(arr[3])&pc=\(arr[4])&pp=\(arr[5])&pz=\(arr[6])&pj=\(arr[7])&pd=\(arr[8])&pa=\(arr[9])&on=\(arr[10])&oc=\(arr[11])&op=\(arr[12])&oz=\(arr[13])&oj=\(arr[14])&oa=\(arr[15])&r=\(arr[16])&d=\(arr[17])&w1=\(arr[18])&w2=\(arr[19])&ct=\(arr[20])&sj=\(arr[21])&k=\(UserInfoLoaclManger.getKey())"
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

    // MARK: 会议室

    func roomgetlist(){
        request.delegate = self
        type = .room
        let url = room_getlist_api   + "k=\(UserInfoLoaclManger.getKey())"
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
        } else if type == .save || type == .newspublic || type == .oversave || type == .casedel || type == .dealdel{
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
        } else if type == .casetype{
            //案件类型
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
        } else if type == .deal{
            let arr = Mapper<dealGetlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }

        } else if type == .getinfo{
            let model = Mapper<getinfoDealModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: model,type : type)
            }

        } else if type == .room{
            let arr = Mapper<roomModel>().mapArray(JSONArray: response as! [[String : Any]])
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
