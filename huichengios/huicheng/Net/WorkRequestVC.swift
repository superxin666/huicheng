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
    case checkcase
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
    
    
    
    func requestSucceed(response: Any) {
        if type == .checkcase {
            let arr = Mapper<checkcaseModel>().mapArray(JSONArray: response as! [[String : Any]])
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
