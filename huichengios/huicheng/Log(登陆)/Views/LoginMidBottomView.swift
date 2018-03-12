
//
//  LoginMidBottomView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class LoginMidBottomView: UIView,NibLoadable {
        
    deinit {
        print("销毁")
    }
    @IBAction func logInClick(_ sender: Any) {
        HCLog(message: "登陆")
    }
    
}
