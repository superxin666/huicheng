//
//  UserInfoLoaclManger.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//  用户信息本地存储

import UIKit
let KEY = "KEY"

class UserInfoLoaclManger: NSObject {
    
    /// 本地存贮key
    ///
    /// - Parameters:
    ///   - key: key
    ///   - complate: 1成功 0失败
    class func storekeyInUD(key : String, complate:(_ data : Any) ->() ){
        UserDefaults.standard.set(key, forKey: KEY)
        let ok = UserDefaults.standard.synchronize()
        if ok {
            print("存储成功")
            complate("1")
        } else {
            print("存储失败")
            complate("0")
        }
    }
    
    /// 获取key
    ///
    /// - Returns: key str
    class func getKey() -> String {
        guard let keyStr = UserDefaults.standard.object(forKey: KEY) else {
            HCLog(message: "没有key")
            return ""
        }
        return keyStr as! String
        
    }
}
