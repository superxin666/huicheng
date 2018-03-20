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
    case noticelist,newslist,newsdetial
}
protocol MessageRequestVCDelegate : NSObjectProtocol{
    //
    func requestSucceed(data:Any) -> Void
     func requestFail() -> Void

}

class MessageRequestVC: UIViewController,BaseNetViewControllerDelegate {
    var delegate :MessageRequestVCDelegate!

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
    
    /// 公告详情
    ///
    /// - Parameter id: 公告id
    func newsdetialRequest(id:Int) {
        request.delegate = self
        type = .newsdetial
        let url =   newsdetial_api + "id=\(id)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }
        
    func requestSucceed(response: Any) {
        if type == .noticelist {
            let arr = Mapper<noticelistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed(data: arr)
            }
        } else if type == .newslist{
            let arr = Mapper<newslistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed(data: arr)
            }
        } else if type == .newsdetial{
            let model = Mapper<newsdetialModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed(data: model)
                
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
