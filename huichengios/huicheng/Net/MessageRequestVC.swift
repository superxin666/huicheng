//
//  MessageRequestVC.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

protocol MessageRequestVCDelegate {
    func requestSucceed(arr : [noticelistModel]) -> Void
    func requestFail() -> Void
    
}

class MessageRequestVC: UIViewController,BaseNetViewControllerDelegate {
    var delegate :MessageRequestVCDelegate!
    let request : BaseNetViewController = BaseNetViewController()

    
    func newslistRequest(p:Int,c:Int = 8) {
        request.delegate = self
        let url =   noticelist_api + "c=\(c)&p=\(p)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }
    func requestSucceed(response: Any) {
        HCLog(message: response)
//        let model = Mapper<noticelistModel>().map(JSON: response as! [String : Any])!
        let arr = Mapper<noticelistModel>().mapArray(JSONArray: response as! [[String : Any]])
        HCLog(message: arr.count)
        if !(self.delegate == nil) {
            self.delegate.requestSucceed(arr: arr)
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
