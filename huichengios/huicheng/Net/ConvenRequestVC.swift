//
//  ConvenRequestVC.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  快捷

import UIKit
import ObjectMapper

enum ConvenRequestVC_enum {
    case getlist
}
protocol ConvenRequestVCDelegate {
    func requestSucceed(data : Any,type : ConvenRequestVC_enum) -> Void
    func requestFail() -> Void
    
}

class ConvenRequestVC: UIViewController, BaseNetViewControllerDelegate {
    var delegate :ConvenRequestVCDelegate!
    let request : BaseNetViewController = BaseNetViewController()
    var type : ConvenRequestVC_enum!
    
    
    
  
    /// 列表
    ///
    /// - Parameters:
    ///   - t: 类型 1 法院 2 检察院 3公安机关 4仲裁委 5看守所
    ///   - kw: 关键字
    func quick_getlistRequest(t : Int, kw : String = "")  {
        request.delegate = self
        type = .getlist
        let url =   quick_getlist_api + "kw=\(kw)&t=\(t)&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    
    // MARK: 网络数据代理
    func requestSucceed(response: Any) {
        if type == .getlist {
            let arr = Mapper<quick_getlistModel>().mapArray(JSONArray: response as! [[String : Any]])
            HCLog(message: arr.count)
            if !(self.delegate == nil) {
                self.delegate.requestSucceed(data: arr,type : .getlist)
            }
        }
    }
    func requestFail(response: Any) {
        
        
    }

}
