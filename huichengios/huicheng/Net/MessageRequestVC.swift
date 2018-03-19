//
//  MessageRequestVC.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper
enum MessageRequestVC_enum {
    case noticelist,newslist
}
protocol MessageRequestVCDelegate : NSObjectProtocol{
    //
     func requestSucceed(arr : [noticelistModel]) -> Void
     func requestFail() -> Void

}
protocol MessageRequestVCDelegate_newslist : NSObjectProtocol{
    //
    func requestFail() -> Void
    func requestSucceed(arr : [newslistModel]) -> Void
}


class MessageRequestVC: UIViewController,BaseNetViewControllerDelegate {
    var delegate :MessageRequestVCDelegate!
    var delegate_newslist :MessageRequestVCDelegate_newslist!
    let request : BaseNetViewController = BaseNetViewController()
    var type : MessageRequestVC_enum!
    
    
    /// 消息页面
    ///
    /// - Parameters:
    ///   - p: 页码
    ///   - c: 个数
    func noticelistRequest(p:Int,c:Int = 8) {
        request.delegate = self
        type = .noticelist
        let url =   noticelist_api + "c=\(c)&p=\(p)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }
    
    
    /// 公告列表
    ///
    /// - Parameters:
    ///   - p: 页码
    ///   - c: 个数
    func newslistRequest(p:Int,c:Int = 8) {
        request.delegate = self
        type = .newslist
        let url =   newslist_api + "c=\(c)&p=\(p)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    
    func requestSucceed(response: Any) {
        if type == .noticelist {
            let arr = Mapper<noticelistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed(arr: arr)
            }
        } else if type == .newslist{
            let arr = Mapper<newslistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate_newslist == nil) {
                self.delegate_newslist.requestSucceed(arr: arr)
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
