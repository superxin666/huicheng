//
//  LogInViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//  登陆

import UIKit
import SnapKit

class LogInViewController: UIViewController,LoginTopViewDelegate {
    var topView : LoginTopView!
    var bottomView : LoginMidBottomView!
    

    
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
        
        self.view.addSubview(self.topView)
        self.view.addSubview(self.bottomView)


        
    }
    
    //MARK: delegate
    func loginTopViewBtnClick(tagNum: Int) {
        if tagNum == 100 {
            HCLog(message: "手机代理")
            bottomView.phoneTextField.tag = 100
            bottomView.codeTextField.tag = 101
            bottomView.phoneImageView.image = #imageLiteral(resourceName: "log_phone")
            bottomView.phoneTextField.placeholder = "手机号"
            bottomView.codeTextField.placeholder = "短信验证码"
            bottomView.getCodeBtn.isHidden = false
        } else {
            HCLog(message: "账号代理")
            bottomView.phoneTextField.tag = 102
            bottomView.codeTextField.tag = 103
            bottomView.phoneImageView.image = #imageLiteral(resourceName: "log_persion")
            bottomView.phoneTextField.placeholder = "手机号/邮箱"
            bottomView.codeTextField.placeholder = "密码"
            bottomView.getCodeBtn.isHidden = true
        }
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
