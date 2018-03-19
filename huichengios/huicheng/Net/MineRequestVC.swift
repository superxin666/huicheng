//
//  MineRequestVC.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//  我的网络

import UIKit
protocol MineRequestVCDelegate {
    func requestSucceed() -> Void
    func requestFail() -> Void
    
}

class MineRequestVC: UIViewController, BaseNetViewControllerDelegate {
    var delegate :MineRequestVCDelegate!
    let request : BaseNetViewController = BaseNetViewController()
    
    /// 读取基本信息
    func user_getinfoRequest() {
        request.delegate = self
        let url =   user_getinfo_api + "k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }
    

    
    func requestSucceed(response: Any) {
        
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
