//
//  LoginTopView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol LoginTopViewDelegate {
    func loginTopViewBtnClick(tagNum : Int)
}

class LoginTopView: UIView,NibLoadable {
    var delegate : LoginTopViewDelegate!
    @IBOutlet weak var leftView: UIView!
    
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var accountBtn: UIButton!
    
    @IBOutlet weak var phoneBtn: UIButton!
    
    @IBAction func phoneclick(_ sender: Any) {
        print("手机快速登陆")
        let btn : UIButton = sender as! UIButton
        accountBtn.isSelected = btn.isSelected
        btn.isSelected = !btn.isSelected

        leftView.isHidden = false
        rightView.isHidden = true
 
        if !(delegate == nil) {
            self.delegate.loginTopViewBtnClick(tagNum: btn.tag)
        }
    }
    
    @IBAction func acountclick(_ sender: Any) {
        print("账号密码登陆")
        let btn : UIButton = sender as! UIButton
        phoneBtn.isSelected = btn.isSelected
        btn.isSelected = !btn.isSelected

        leftView.isHidden = true
        rightView.isHidden = false
        if !(delegate == nil)  {
            self.delegate.loginTopViewBtnClick(tagNum: btn.tag)
        }

    }

}
