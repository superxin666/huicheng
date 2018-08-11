//
//  UserDataSingle.swift
//  huicheng
//
//  Created by lvxin on 2018/8/11.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
private let sharedKraken = UserDataSingle()

class UserDataSingle: NSObject {

    var dataModel : LoginModel!


    class var sharedInstance: UserDataSingle {
        return sharedKraken
    }


}
