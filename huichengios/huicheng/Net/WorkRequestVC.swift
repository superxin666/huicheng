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
         newslist1//公告  获取列表
}
protocol WorkRequestVCDelegate : NSObjectProtocol{
    //
    func requestSucceed(data:Any) -> Void
    func requestFail() -> Void
    
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
        let url =   newslist1_api + "p=\(p)&c=\(c)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    
    
    func requestSucceed(response: Any) {
        if type == .checkcase {
            //利益冲突检查
            let arr = Mapper<checkcaseModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed(data: arr)
            }
        } else if type == .newslist1{
            //公告  获取列表
            let arr = Mapper<newslist1Model>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed(data: arr)
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
