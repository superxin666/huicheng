//
//  MineRequestVC.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//  我的网络

import UIKit
import ObjectMapper
enum MineRequestVC_enum {
    case user_getinfo,invoice_getlist,newsdetial
}

protocol MineRequestVCDelegate {
    func requestSucceed(data : Any) -> Void
    func requestFail() -> Void
    
}

class MineRequestVC: UIViewController, BaseNetViewControllerDelegate {
    var delegate :MineRequestVCDelegate!
    let request : BaseNetViewController = BaseNetViewController()
    var type : MineRequestVC_enum!
    
    /// 读取基本信息
    func user_getinfoRequest() {
        request.delegate = self
        type = .user_getinfo
        let url =   user_getinfo_api + "k=\(UserInfoLoaclManger.getKey())"
        request.request_api(url: url)

    }
    ///  报销申请 获取列表
    func expense_getlistRequest(p : Int, c: Int) {
        let url =   expense_getlist + "c=\(c)&p=\(p)&k=\(UserInfoLoaclManger.getKey())"
        request.delegate = self
        type = .invoice_getlist
        request.request_api(url: url)
    }

    ///  发票申请 获取列表
    func invoice_getlistRequest() {
        let url =   invoice_getlist + "k=\(UserInfoLoaclManger.getKey())"
        request.delegate = self
        type = .invoice_getlist
        request.request_api(url: url)
    }
    func requestSucceed(response: Any) {
        if type == .user_getinfo {
            let model = Mapper<user_getinfoModel>().map(JSON: response as! [String : Any])!
            if !(self.delegate == nil) {
                self.delegate.requestSucceed(data: model)
            }
        } else if type == .invoice_getlist{
            let arr = Mapper<expense_getlistModel>().mapArray(JSONArray: response as! [[String : Any]])
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
