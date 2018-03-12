//
//  LoginTopView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class LoginTopView: UIView,NibLoadable {

    
    @IBAction func phoneclick(_ sender: Any) {
        print("手机快速登陆")
    }
    
    @IBAction func acountclick(_ sender: Any) {
        print("账号密码登陆")
    }
    
}
