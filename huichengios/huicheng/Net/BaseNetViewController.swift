//
//  BaseNetViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON
protocol BaseNetViewControllerDelegate: NSObjectProtocol{
    func requestSucceed(response :Any) -> Void
    func requestFail(response :Any) -> Void
}
enum reponsetype {
    case datatype
    case alltyper
}

class BaseNetViewController: UIViewController {
    weak var delegate :BaseNetViewControllerDelegate!

    func request_api(url : String,type :  reponsetype = .datatype){
        let url = base_api + url
        HCLog(message: url)
        Alamofire.request(url, method: .get).responseJSON { (returnResult) in
            print("secondMethod --> get 请求 --> returnResult = \(returnResult)")
            if let json = returnResult.result.value {
                let model = Mapper<CodeData>().map(JSON: json as! [String : Any])!
                if model.code == 1 {
                    if self.delegate != nil {
                        if type == .datatype{
                            if let data = model.data {
                                self.delegate.requestSucceed(response: data)
                            } else {
                                self.delegate.requestSucceed(response: json)
                            }
                        } else {
                            self.delegate.requestSucceed(response: json)
                        }
                     }
                } else {
                    SVPMessageShow .showErro(infoStr: model.msg)
                    self.delegate.requestFail(response:json)
                }
                
            } else {
                
                HCLog(message: "请求错误1："+returnResult.debugDescription)
                if self.delegate != nil {
                    SVPMessageShow .showErro(infoStr: "请求失败")
                }
            }
        }
        
    }

}
