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
         save,newslist1,getobjectlist,newspublic,del//公告  发布/编辑公告  获取列表  获取接收对象  发布/撤销公告  删除
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
    
    
    
    func requestSucceed(response: Any) {
        if type == .checkcase {
            //利益冲突检查
            let arr = Mapper<checkcaseModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: arr,type : type)
            }
        } else if type == .newslist1{
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
        } else if type == .save || type == .newspublic{
            //发布公告
            let model = Mapper<CodeData>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed_work(data: model,type : type)
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
