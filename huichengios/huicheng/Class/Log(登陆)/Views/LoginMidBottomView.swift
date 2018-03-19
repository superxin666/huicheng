
//
//  LoginMidBottomView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol LoginMidBottomViewDelegate {
    func login()
    
}

class LoginMidBottomView: UIView,NibLoadable {
    var delegate : LoginMidBottomViewDelegate!
    
    @IBOutlet weak var logBtn: UIButton!
    @IBOutlet weak var getCodeBtn: UIButton!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var phoneImageView: UIImageView!
    
    @IBAction func forgetClick(_ sender: Any) {
        HCLog(message: "忘记密码")
    }
    
    @IBAction func logInClick(_ sender: Any) {
        HCLog(message: "登陆")
        if !(self.delegate == nil) {
            self.delegate.login()
        }
    }
    
    @IBAction func getCodeClick(_ sender: Any) {
        HCLog(message: "获取验证码")
    }
    

    @IBAction func fieldEnd(_ sender: UITextField, forEvent event: UIEvent) {
        if sender.tag == 100 {
            HCLog(message: "手机号" + sender.text!)
        } else if sender.tag == 101 {
             HCLog(message: "验证码" + sender.text!)
        } else if sender.tag == 102 {
             HCLog(message: "账号" + sender.text!)
        } else {
             HCLog(message: "密码" + sender.text!)
        }
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    override func awakeFromNib() {
        logBtn.hc_makeRadius(radius: ip6(24))
    }
    
}
