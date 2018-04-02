//
//  SVPMessageShow.swift
//  xueji
//
//  Created by lvxin on 2018/1/4.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import SVProgressHUD
class SVPMessageShow: NSObject {
    /// 错误信息提示 1s
    ///
    /// - Parameter infoStr: <#infoStr description#>
    static func showErro(infoStr:String){
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMaximumDismissTimeInterval(1)
        SVProgressHUD.showError(withStatus: infoStr)
        
    }
    
    /// 成功提示 1s
    ///
    /// - Parameter infoStr: <#infoStr description#>
    static func showSucess(infoStr:String) {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMaximumDismissTimeInterval(1)
        SVProgressHUD.showSuccess(withStatus: infoStr)
    }
    
    
    /// 加载中提示 手动去除
    static func showLoad(title : String = "正在努力加载中") {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.show(withStatus: title)
    }
    
    /// 去除view
    static func dismissSVP() {
        SVProgressHUD.dismiss()
    }
}
