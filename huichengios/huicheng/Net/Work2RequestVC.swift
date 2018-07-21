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
    case income_getlist,income_getdeals,income_getdealsinfo,income_save//收款登记获取列表
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
        }
    }

    func requestFail(response: Any) {

    }

}
