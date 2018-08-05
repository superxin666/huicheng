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
    doc_applylist,doc_search
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
    ///  获取列表
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - bid: <#bid description#>
    ///   - n: <#n description#>
    ///   - t: <#t description#>
    ///   - b: <#b description#>
    ///   - e: <#e description#>
    ///   - u: <#u description#>
    func income_getlistReuest(p:Int,c:Int,bid:Int,n:String,b:String,e:String,u:String,s:String) {
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

        let url =   finance_income_getlist_api + "p=\(p)&c=\(c)&n=\(nStr)&b=\(bStr)&e=\(eStr)&u=\(uStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }


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


    func income_getdealsinfoRequest(id : Int)  {
        type = .income_getdealsinfo
        request.delegate = self
        let url =   finance_income_getdealsinfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url,type: .alltyper)
    }

    

    func income_save(id : String,dealid : String,amount : String,addtime : String,user : String,ispaper : String,papernum : String,money : String,invoicetype : String,creditcode : String,issubmit : String) {

        type = .income_save
        request.delegate = self
        let userStr = user.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        let url =   finance_income_save_api + "id=\(id)&dealid=\(dealid)&amount=\(amount)&addtime=\(addtime)&user=\(userStr)&ispaper=\(ispaper)&papernum=\(papernum)&money=\(money)&invoicetype=\(invoicetype)&creditcode=\(creditcode)&issubmit=\(issubmit)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)


    }


    func income_getinfoRequest(id :Int) {
        type = .income_getinfo
        request.delegate = self
        let url =   finance_income_getinfo_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url,type: .alltyper)

    }
    // MARK: -  签章

    /// 函件审核
    ///
    /// - Parameters:
    ///   - p: <#p description#>
    ///   - c: <#c description#>
    ///   - bid: <#bid description#>
    ///   - n: <#n description#>
    func doc_applylistRequest(p:Int,c:Int,bid:Int,n:String) {
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
        if bStr.count > 0 {
            bStr = b.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }

        var eStr = ""
        if eStr.count > 0 {
            eStr = e.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        }

        let url =   doc_searchapi + "dn=\(dn)&bid=\(bid)&n=\(n)&kw=\(kwStr)&u=\(uStr)&cn=\(cnStr)&b=\(bStr)&e=\(eStr)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }

    func requestSucceed(response: Any) {
        if type == .income_getlist ||  type == .income_getdeals{
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
        } else if type == .doc_applylist || type == .doc_search{
            let arr = Mapper<docgetlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work2(data: arr,type : type)
            }
        }
    }

    func requestFail(response: Any) {

    }

}
