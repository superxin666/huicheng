//
//  UserInfoLoaclManger.swift
//  huicheng
//
//  Created by lvxin on 2018/3/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//  用户信息本地存储

import UIKit
import ObjectMapper

let KEY = "KEY"
let UserWorkData = "UserWorkData"

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

    class func setUserWorkData(data : Any, complate:(_ data : Any) ->() ) {
        UserDefaults.standard.set(data, forKey: UserWorkData)
        let ok = UserDefaults.standard.synchronize()
        if ok {
            print("存储成功")
            complate("1")
        } else {
            print("存储失败")
            complate("0")
        }
    }


    class func getsetUserWorkData() ->  LoginModel{
        let dict :Dictionary<String, Any>? = UserDefaults.standard.value(forKey: UserWorkData) as! Dictionary<String, Any>?
        let  model :  LoginModel = Mapper<LoginModel>().map(JSON: dict!)!
        return model

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
    
    /// 清除key
    class func cleanKey()  {
        UserDefaults.standard.set("", forKey: KEY)
    }
}
