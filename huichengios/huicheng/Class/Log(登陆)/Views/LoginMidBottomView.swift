
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

class LoginMidBottomView: UIView,NibLoadable,LoginRequestVCDelegate {
    var delegate : LoginMidBottomViewDelegate!
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var logBtn: UIButton!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phoneImageView: UIImageView!
    
    var phoneStr : String = ""
    var codeStr : String = ""
    let request : LoginRequestVC = LoginRequestVC()
    var time : Timer!
    var timeNum = 60
    
    
    @IBAction func forgetClick(_ sender: Any) {
        HCLog(message: "忘记密码")
    }
    
    @IBAction func logInClick(_ sender: Any) {
        HCLog(message: "登陆")
        if !(self.delegate == nil) {
            self.delegate.login()
        }
    }
    
 

    @IBAction func fieldEnd(_ sender: UITextField, forEvent event: UIEvent) {
        if sender.tag == 100 {
            HCLog(message: "手机号" + sender.text!)
//            phoneStr = sender.text!
            if let str = sender.text {
                phoneStr = str
            }
        } else if sender.tag == 101 {
             HCLog(message: "验证码" + sender.text!)
            if let str = sender.text {
                codeStr = str
            }
        } else if sender.tag == 102 {
             HCLog(message: "账号" + sender.text!)
        } else {
             HCLog(message: "密码" + sender.text!)
        }
       
    }
    
    @objc func getCode() {
        HCLog(message: "获取验证码")
        request.delegate = self
        if phoneTextField.isFirstResponder {
            phoneTextField.resignFirstResponder()
        }
        if !(phoneStr.count > 0) {
            SVPMessageShow.showErro(infoStr: "请输入手机号")
            return
        }
        time = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(timeDown), userInfo: nil, repeats: true)
        request.sendcodeRequest(m: phoneStr)
        
    }
    
    @objc func timeDown() {
        
        timeNum -= 1
        if timeNum == 0 {
            codeLabel.isUserInteractionEnabled = true
            time.invalidate()
            time = nil
            codeLabel.text = "重新获取"
        } else {
            
            codeLabel.isUserInteractionEnabled = false
            codeLabel.text = "\(timeNum)"
        }
        
    }
    
    func requestSucceed() {
        SVPMessageShow.showSucess(infoStr: "已发送")
    }
    
    func requestFail() {
        HCLog(message: "失败123")
        codeLabel.isUserInteractionEnabled = true
        timeNum = 60
        time.fireDate = Date.distantFuture
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    override func awakeFromNib() {
        logBtn.hc_makeRadius(radius: ip6(24))
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getCode))
        self.codeLabel.addGestureRecognizer(tap)
    }
    
}
