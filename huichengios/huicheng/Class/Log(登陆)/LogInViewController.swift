//
//  LogInViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//  登陆

import UIKit
import SnapKit

class LogInViewController: UIViewController,LoginTopViewDelegate,LoginMidBottomViewDelegate,LoginRequestVCDelegate {
    var topView : LoginTopView!
    var bottomView : LoginMidBottomView!
    let request = LoginRequestVC()
    
    
    override func viewWillLayoutSubviews() {
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(self.view).offset(0)
            make.height.equalTo(topView.snp.width).multipliedBy(18.0/25.0)
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(45)
            make.left.equalTo(self.view).offset(0)
            make.width.equalTo(self.view).offset(0)
            make.height.equalTo(bottomView.snp.width).multipliedBy(220.0/375.0)
        }
  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        topView = LoginTopView.loadNib()
        topView.delegate = self
        bottomView = LoginMidBottomView.loadNib()
        bottomView.delegate = self
        request.delegate = self
        self.view.addSubview(self.topView)
        self.view.addSubview(self.bottomView)
        
    }
    
    //MARK: delegate
    func loginTopViewBtnClick(tagNum: Int) {
        bottomView.phoneTextField.text = ""
        bottomView.codeTextField.text = ""

        if tagNum == 100 {
            HCLog(message: "手机代理")
            bottomView.phoneTextField.keyboardType = .numberPad
            bottomView.phoneTextField.tag = 100
            bottomView.codeTextField.tag = 101
            
            bottomView.phoneImageView.image = #imageLiteral(resourceName: "log_phone")
            bottomView.phoneTextField.placeholder = "手机号"
            bottomView.codeTextField.placeholder = "短信验证码"
            bottomView.getCodeBtn.isHidden = false
        } else {
            HCLog(message: "账号代理")
            bottomView.phoneTextField.keyboardType = .default
            
            bottomView.phoneTextField.tag = 102
            bottomView.codeTextField.tag = 103
            bottomView.phoneImageView.image = #imageLiteral(resourceName: "log_persion")
            bottomView.phoneTextField.placeholder = "手机号/邮箱"
            bottomView.codeTextField.placeholder = "密码"
            bottomView.getCodeBtn.isHidden = true
        }
    }
    func login() {
        if bottomView.phoneTextField.isFirstResponder {
            bottomView.phoneTextField.resignFirstResponder()
        }
        if bottomView.codeTextField.isFirstResponder {
            bottomView.codeTextField.resignFirstResponder()
        }
        //"bjadmin"
        guard let uStr = bottomView.phoneTextField.text else {
            HCLog(message: "输入手机号或者账号")
            SVPMessageShow.showErro(infoStr: "输入手机号或者账号")
            return
        }
        guard  let pStr = bottomView.codeTextField.text else {
            HCLog(message: "输入密码")
            SVPMessageShow.showErro(infoStr: "输入密码")
            return
        }
        if !(uStr.count>0) {
            SVPMessageShow.showErro(infoStr: "输入手机号或者账号")
            return
        }
        if !(pStr.count>0) {
            SVPMessageShow.showErro(infoStr: "输入密码")
            return
        }
        //登陆请求
        HCLog(message:"账号\(uStr)")
        HCLog(message:"密码\(pStr)")
        
        request.loginRequest(u: uStr, p: pStr)
        
    }
    func requestSucceed() {
        let dele :AppDelegate = UIApplication.shared.delegate as! AppDelegate
        SVPMessageShow.showSucess(infoStr: "登录成功")
        dele.showMain()
    }
    func requestFail() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
