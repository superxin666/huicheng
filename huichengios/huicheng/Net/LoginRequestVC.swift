//
//  LoginRequestVC.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper

protocol LoginRequestVCDelegate {
    func requestSucceed() -> Void
    func requestFail() -> Void

}
class LoginRequestVC: UIViewController,BaseNetViewControllerDelegate {
    
    var delegate :LoginRequestVCDelegate!
    let request : BaseNetViewController = BaseNetViewController()

    
    /// 登陆请求
    ///
    /// - Parameters:
    ///   - u: 账号
    ///   - p: 密码
    func loginRequest(u:String,p:String) {
        request.delegate = self
        let uStr : String = u.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url =   login_api + "u=\(uStr)&p=\(p)"
        request.request_api(url: url)
        
    }
    
    /// 手机号登陆
    ///
    /// - Parameters:
    ///   - m: <#m description#>
    ///   - n: <#n description#>
    func mobileloginRequest(m:String,n:String) {
        request.delegate = self

        let url =   mobilelogin_api + "m=\(m)&n=\(n)"
        request.request_api(url: url)
    }
    
    
    /// 获取验证码
    ///
    /// - Parameter m: <#m description#>
    func sendcodeRequest(m: String) {
        request.delegate = self
        let url =   sendcode_api + "&m=\(m)"
        request.request_api(url: url)
    }
    
    func requestSucceed(response: Any) {
        HCLog(message: response)
        let model = Mapper<LoginModel>().map(JSON: response as! [String : Any])!
        guard let key = model.key else {
            HCLog(message: "key 为nil")
            return
        }
        UserInfoLoaclManger.storekeyInUD(key: key) { (result) in
            let str:String = result as! String
            if str == "1"{
                //存储成工
                if self.delegate != nil {
                    self.delegate.requestSucceed()
                }
            }

        }
        
    }
    
    func requestFail(response: Any) {
        self.delegate.requestFail()
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
