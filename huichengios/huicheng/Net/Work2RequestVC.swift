//
//  Work2RequestVC.swift
//  huicheng
//
//  Created by lvxin on 2018/6/8.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

enum Work2RequestVC_enum {
    //
    case income_getlist,income_getdeals,income_getdealsinfo,income_save,income_getinfo,//收款登记获取列表
    doc_applylist,doc_search,doc_getlist,doc_applysave,doc_getinfo,doc_del,crt_dealslist,crt_choose,crt_getinfo,crt_save,pay_getlist,pay_applyinfo,pay_del,pay_applysave,pay_save,pay_applylist,income_additem,financeincome_save,income_del,income_cancel,income_getcount,usermanage,usermanageInfo
}
protocol Work2RequestVCDelegate : NSObjectProtocol{
    //
    func requestSucceed_work2(data:Any,type : Work2RequestVC_enum) -> Void
    func requestFail_work2() -> Void

}

class Work2RequestVC: UIViewController,BaseNetViewControllerDelegate {
    var delegate :Work2RequestVCDelegate!
    let request : BaseNetViewController = BaseNetViewController()
    var type : Work2RequestVC_enum!

    // MARK: -  财务
//--------财务
    ///   收款登记 获取列表
    ///
    /// - Parameters:
    ///     - p: <#p description#>
    ///   - c: <#c description#>
    ///   - bid: <#bid description#>
    ///   - n: <#n description#>
    ///   - t: <#t description#>
    ///   - b: <#b description#>
    ///   - e: <#e description#>
    ///   - u: <#u description#>
    func income_getlistReuest(p:Int,c:Int,bid:String,n:String,b:String,e:String,u:String,s:String) {
        request.delegate = self
        type = .income_getlist
        var nStr = ""
        if n.count > 0 {
            nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
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

        let url =   finance_income_getlist_api + "p=\(p)&c=\(c)&bid=\(bid)&s=\(s)&n=\(nStr)&b=\(bStr)&e=\(eStr)&u=\(uStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }


    /// 新增收款-获取合同列表
    ///
    /// - Parameters:
    ///   - u: <#u description#>
    ///   - n: <#n description#>
    ///   - kw: <#kw description#>
    func income_getdealsRequest(u:String,n:String,kw:String) {
        request.delegate = self
        type = .income_getdeals
        var nStr = ""
        if n.count > 0 {
            nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var uStr = ""
        if u.count > 0 {
            uStr = u.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var kwStr = ""
        if kw.count > 0 {
            kwStr = kw.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        let url =   finance_income_getdeals_api + "n=\(nStr)&u=\(uStr)&kw=\(kwStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }


    /// 新增收款-获取合同详情
    ///
    /// - Parameter id: <#id description#>
    func income_getdealsinfoRequest(id : Int)  {
        type = .income_getdealsinfo
        request.delegate = self
        let url =   finance_income_getdealsinfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url,type: .alltyper)
    }

    

    /// 新增收款-保存收款信息为草稿
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - dealid: <#dealid description#>
    ///   - amount: <#amount description#>
    ///   - addtime: <#addtime description#>
    ///   - user: <#user description#>
    ///   - ispaper: <#ispaper description#>
    ///   - papernum: <#papernum description#>
    ///   - money: <#money description#>
    ///   - invoicetype: <#invoicetype description#>
    ///   - creditcode: <#creditcode description#>
    ///   - issubmit: <#issubmit description#>
    func income_save(id : String,dealid : String,amount : String,addtime : String,user : String,ispaper : String,papernum : String,money : String,invoicetype : String,creditcode : String,issubmit : String) {

        type = .income_save
        request.delegate = self
        let userStr = user.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let addtimeStr = addtime.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        let papernumStr = papernum.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let creditcodeStr = creditcode.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!



        let url =   finance_income_save_api + "id=\(id)&dealid=\(dealid)&amount=\(amount)&addtime=\(addtimeStr)&user=\(userStr)&ispaper=\(ispaper)&papernum=\(papernumStr)&money=\(money)&invoicetype=\(invoicetype)&creditcode=\(creditcodeStr)&issubmit=\(issubmit)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)


    }


    /// 获取详情
    ///
    /// - Parameter id: <#id description#>
    func income_getinfoRequest(id :String) {
        type = .income_getinfo
        request.delegate = self
        let url =   finance_income_getinfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url,type: .alltyper)

    }


    /// 增加收款明细信息
    ///
    /// - Parameters:
    ///   - d: <#d description#>
    ///   - t: <#t description#>
    ///   - m: <#m description#>
    ///   - o: <#o description#>
    func income_additemRequest(d : String, t : String,m : String,o:String)  {
        type = .income_additem
        request.delegate = self
        let url =   finance_income_additem_api + "d=\(d)&t=\(t)&m=\(m)&o=\(o)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }


    /// 提交审核
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - issubmit: <#issubmit description#>
    func income_save(id : String, issubmit : String) {
        type = .financeincome_save
        request.delegate = self
        let url =   finance_income_save_api + "id=\(id)&issubmit=\(issubmit)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }



    /// 删除
    ///
    /// - Parameter id: <#id description#>
    func income_del(id : String)  {
        type = .income_del
        request.delegate = self
        let url =   finance_income_del_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    /// 撤回
    ///
    /// - Parameter id: <#id description#>
    func income_cancel(id : String)  {
        type = .income_cancel
        request.delegate = self
        let url =   finance_income_cancel_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }


    /// 统计报表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - n: <#n description#>
    ///   - b: <#b description#>
    ///   - e: <#e description#>
    ///   - u: <#u description#>
    ///   - bid: <#bid description#>
    ///   - s: <#s description#>
    ///   - d: <#d description#>
    func income_getcountRequest(p:Int,c:Int,n : String, b : String, e : String, u : String, bid : String, s : String, d : String) {
        type = .income_getcount
        request.delegate = self


        var bStr = ""
        if b.count > 0 {
            bStr = b.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }

        var eStr = ""
        if e.count > 0 {
            eStr = e.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }

        var uStr = ""
        if u.count > 0 {
            uStr = u.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }



        let url =   finance_income_getcount_api + "p=\(p)&c=\(c)&n=\(n)&b=\(bStr)&e=\(eStr)&u=\(uStr)&bid=\(bid)&s=\(s)&d=\(d)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    // MARK: -  签章




    /// 获取函件列表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - n: <#n description#>
    ///   - bid: <#bid description#>
    func docgetlistRequset(p:Int,c:Int,n:String,bid:String,dn:String,s:String,lv:String,nm:String,bd:String,ed:String) {
        request.delegate = self
        type = .doc_getlist

        var sStr = ""
        if s.count > 0 {
            sStr = s.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }

        var lvStr = ""
        if lv.count > 0 {
            lvStr = lv.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var nmStr = ""
        if nm.count > 0 {
            nmStr = nm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var bdStr = ""
        if bd.count > 0 {
            bdStr = bd.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var edStr = ""
        if ed.count > 0 {
            edStr = ed.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }




        let url = doc_getlist_api   + "bid=\(bid)&p=\(p)&c=\(c)&n=\(n)&s=\(sStr)&lv=\(lvStr)&nm=\(nmStr)&bd=\(bdStr)&ed=\(edStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }


    /// 详情
    ///
    /// - Parameter id: <#id description#>
    func docgetinfoRequset(id:String) {
        request.delegate = self
        type = .doc_getinfo
        let url = doc_getinfo_api   + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }

    /// 删除
    ///
    /// - Parameter id: <#id description#>
    func docdelRequset(id:String) {
        request.delegate = self
        type = .doc_del
        let url = doc_del_api   + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }


    /// 生成函件
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - n: 合同编号
    ///   - t: 1-诉讼案件;2-非诉案件;3-刑事案件;4-法律顾问
    func crt_dealslistRequest(bid : String,p:Int,c:Int,n:String,t:Int) {
            request.delegate = self
            type = .crt_dealslist
            let url = doc_crt_dealslist_api   + "p=\(p)&c=\(c)&n=\(n)&t=\(t)&bid=\(bid)&k=\(UserInfoLoaclManger.getKey())"
            request.request_api(url: url)
    }

    /// 获取函件列表
    ///
    /// - Parameter id: <#id description#>
    func crt_chooseReuqest(id : Int) {
        request.delegate = self
        type = .crt_choose
        let url = doc_crt_choose_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }

    /// 获取函件内容及格式
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - f: <#f description#>
    func crt_getinfoReqeust(id : Int,f:Int) {
        request.delegate = self
        type = .crt_getinfo
        let url = doc_crt_getinfo_api + "id=\(id)&f=\(f)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url,type: .alltyper)

    }


    /// 获取函件内容及格式(此为难点)
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - dataArr: <#dataArr description#>
    func crt_saveRequest(id :Int,dataArr : [CrtGetinfoModel_items]) {
        request.delegate = self
        type = .crt_save
        var urlIteamsStr = ""
        var urlIteamsStr2 = ""
        SVPMessageShow.showLoad()
        for subModel in dataArr {
            if subModel.name != "attr"{
                let valueStr = subModel.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                let  str = "&\(subModel.name!)=\(valueStr)"
                urlIteamsStr = urlIteamsStr + str
            } else {
                let valueStr = subModel.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                let  str = "&\(subModel.name!)=\(valueStr)"
                urlIteamsStr2 = urlIteamsStr2 + str
            }
        }




        let url = doc_crt_save_api + "k=\(UserInfoLoaclManger.getKey())&id=\(id)\(urlIteamsStr)\(urlIteamsStr2)"
        HCLog(message: "121212")
        HCLog(message: url)

        request.request_api(url: url)
    }

    /// 函件审核
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - bid: <#bid description#>
    ///   - n: <#n description#>
    func doc_applylistRequest(p:Int,c:Int,bid:String,n:String) {
        type = .doc_applylist
        request.delegate = self
        let url =   doc_applylistapi + "p=\(p)&c=\(c)&n=\(n)&bid=\(bid)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }


    /// 函件查询
    ///
    /// - Parameters:
    ///   - dn: <#dn description#>
    ///   - bid: <#bid description#>
    ///   - n: <#n description#>
    ///   - kw: <#kw description#>
    ///   - u: <#u description#>
    ///   - cn: <#cn description#>
    ///   - b: <#b description#>
    ///   - e: <#e description#>
    func doc_searchReuqest(dn:String,bid:String,n:String,kw:String,u:String,cn:String,b:String,e:String) {
        type = .doc_search
        request.delegate = self

        var uStr = ""
        if u.count > 0 {
            uStr = u.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var kwStr = ""
        if kw.count > 0 {
            kwStr = kw.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var cnStr = ""
        if cn.count > 0 {
            cnStr = cn.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var bStr = ""
        if b.count > 0 {
            bStr = b.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }

        var eStr = ""
        if e.count > 0 {
            eStr = e.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }

        let url =   doc_searchapi + "dn=\(dn)&bid=\(bid)&n=\(n)&kw=\(kwStr)&u=\(uStr)&cn=\(cnStr)&b=\(bStr)&e=\(eStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }


    /// 获取函件列表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - bid: <#bid description#>
    ///   - n: <#n description#>
    func doc_getlist(p:Int,c:Int,bid:Int,n:String) {
        type = .doc_getlist
        request.delegate = self
        let url =   doc_getlistapi + "p=\(p)&c=\(c)&n=\(n)&bid=\(bid)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }


    /// 印章
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - s: 3为通过，2为驳回
    ///   - n: <#n description#>
    ///   - x: <#x description#>
    ///   - y: <#y description#>
    func doc_applysave(id:Int,s:String,n:String,x:Int,y:Int) {
        type = .doc_applysave
        request.delegate = self
        let nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url =   doc_applysave_api + "id=\(id)&s=\(s)&x=\(x)&y=\(y)&top=\(0)&n=\(nStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }

    // MARK: -  支付


    /// 获取详情
    ///
    /// - Parameter id: <#id description#>
    func financePayapplyinfo(id : String) {
        SVPMessageShow.showLoad()
        type = .pay_applyinfo
        request.delegate = self
        let url =   finance_pay_applyinfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url,type: .alltyper)
    }


    /// 支付审批  获取列表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - n: <#n description#>
    ///   - u: <#u description#>
    ///   - b: <#b description#>
    ///   - e: <#e description#>
    ///   - bid: <#bid description#>
    func pay_applylistRequest(p:Int,c:Int,n:String,u:String,b:String,e:String,bid:String) {


        type = .pay_applylist
        request.delegate = self


        var nStr = ""
        if n.count > 0 {
            nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
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
            eStr = e.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }

        let url =   finance_pay_applylist_api + "p=\(p)&c=\(c)&n=\(nStr)&u=\(uStr)&bid=\(bid)&b=\(bStr)&e=\(eStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }


    /// 线下支付  获取列表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - no: <#no description#>
    ///   - n: <#n description#>
    ///   - s: <#s description#>
    ///   - st: <#st description#>
    ///   - et: <#et description#>
    func financePayGetlistRequest(p:Int,c:Int,no:String,n:String,s:String,st:String,et:String) {
        type = .pay_getlist
        request.delegate = self


        var noStr = ""
        if no.count > 0 {
            noStr = no.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var nStr = ""
        if n.count > 0 {
            nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var bStr = ""
        if st.count > 0 {
            bStr = st.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }

        var eStr = ""
        if et.count > 0 {
            eStr = et.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }

        let url =   finance_pay_getlist_api + "p=\(p)&c=\(c)&no=\(noStr)&n=\(nStr)&s=\(s)&st=\(bStr)&et=\(eStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }


    /// 线下支付保存
    ///
    /// - Parameter id: <#id description#>
    func pay_saveRequest(id : String)  {
        SVPMessageShow.showLoad()
        type = .pay_save
        request.delegate = self
        let url =   finance_pay_save_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    /// 审核保存
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - s: <#s description#>
    ///   - n: <#n description#>
    func pay_applysaveRequest(id:String,s: String,n:String)  {
        SVPMessageShow.showLoad()
        type = .pay_applysave
        request.delegate = self

        var nStr = ""
        if n.count > 0 {
            nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        let url =   finance_pay_applysave_api + "id=\(id)&s=\(s)&n=\(nStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }

    /// 删除
    ///
    /// - Parameter id: <#id description#>
    func pay_delRequest(id : String) {
        SVPMessageShow.showLoad()
        type = .pay_del
        request.delegate = self
        let url =   finance_pay_del_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }

     // MARK: -  人员查询
    func usermanageReuqet(subStr:String,p:Int,c:Int,bid:String,u:String,n:String,d:String,ca:String,dp:String,s:String,bd:String,ed:String)  {

        type = .usermanage
        request.delegate = self


        var uStr = ""
        if u.count > 0 {
            uStr = u.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var nStr = ""
        if n.count > 0 {
            nStr = n.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
        var bStr = ""
        if bd.count > 0 {
            bStr = bd.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }

        var eStr = ""
        if ed.count > 0 {
            eStr = ed.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }
//

        type = .usermanage
        request.delegate = self
        //&bid=\(bid)
        let url =   usermanage_api + "bid=\(subStr)&p=\(p)&c=\(c)&u=\(uStr)&n=\(nStr)&d=\(d)&ca=\(ca)&dp=\(dp)&s=\(s)&bd=\(bStr)&ed=\(eStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }


    /// 详情
    ///
    /// - Parameter id: <#id description#>
    func usermanageInfo(id : String) {
        type = .usermanageInfo
        request.delegate = self
        let url =   usermanageInfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url,type: .alltyper)

    }



    func requestSucceed(response: Any) {
        SVPMessageShow.dismissSVP()
        if type == .income_getlist ||  type == .income_getdeals {
            let arr = Mapper<Income_getlistModel>().mapArray(JSONArray: response as! [[String : Any]])

            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: arr,type : type)
            }
        } else if type == .income_getdealsinfo{

            let model = Mapper<income_getdealsinfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: model,type : type)
            }
        } else if type == .income_getinfo{
            let model = Mapper<income_getinfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: model,type : type)
            }
        } else if type == .doc_applylist || type == .doc_search || type == .doc_getlist{
            let arr = Mapper<docgetlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: arr,type : type)
            }
        } else if type == .doc_getinfo{
            let model = Mapper<docgetinfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: model,type : type)
            }
        } else if type == .doc_del || type == .crt_save || type == .doc_applysave || type == .pay_del || type == .pay_applysave || type == .pay_save || type == .income_additem || type == .income_save || type == .financeincome_save || type == .income_del || type == .income_cancel{
            let model = Mapper<CodeData>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: model,type : type)
            }
        } else if type == .crt_dealslist {
            let arr = Mapper<CrtDealslistModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: arr,type : type)
            }
        } else if type == .crt_choose {
            let arr = Mapper<crt_chooseModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: arr,type : type)
            }
        } else if type == .crt_getinfo{
            let model = Mapper<CrtGetinfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: model,type : type)
            }
        } else if type == .pay_getlist || type == .pay_applylist{
            let arr = Mapper<payGetlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: arr,type : type)
            }
        } else if type == .pay_applyinfo{
            let model = Mapper<pay_applyinfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: model,type : type)
            }
        } else if type == . income_getcount{
            let arr = Mapper<income_getcountModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: arr,type : type)
            }
        }else if type == . usermanage{
            let arr = Mapper<usermanageModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: arr,type : type)
            }
        }else if type == . usermanageInfo{

            let model = Mapper<usermanageInfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: model,type : type)
            }
        }


    }

    func requestFail(response: Any) {

    }

}
