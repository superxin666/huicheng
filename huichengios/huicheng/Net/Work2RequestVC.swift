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
    case income_getlist//收款登记获取列表
}
protocol Work2RequestVCDelegate : NSObjectProtocol{
    //
    func requestSucceed_work2(data:Any,type : WorkRequestVC_enum) -> Void
    func requestFail_work2() -> Void

}

class Work2RequestVC: UIViewController,BaseNetViewControllerDelegate {
    var delegate :Work2RequestVCDelegate!
    let request : BaseNetViewController = BaseNetViewController()
    var type : Work2RequestVC_enum!



    func income_getlistReuest() {
        request.delegate = self
        type = .income_getlist
        let url =   checkcase_api + "&k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)
    }
    

    func requestSucceed(response: Any) {

    }

    func requestFail(response: Any) {

    }

}
