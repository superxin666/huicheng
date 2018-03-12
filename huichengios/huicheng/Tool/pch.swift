//
//  pch.swift
//  学记
//
//  Created by lvxin on 2017/8/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//
//import Foundation
import UIKit
import Kingfisher
import SVProgressHUD
//MARK:尺寸
let KSCREEN_WIDTH = UIScreen.main.bounds.size.width
let KSCREEN_HEIGHT = UIScreen.main.bounds.size.height

var ip6 = { (num : Int) ->  CGFloat in
    return CGFloat(num)/375 * CGFloat(KSCREEN_WIDTH)
}


let iPhoneX = __CGSizeEqualToSize((UIScreen.main.currentMode?.size)!, CGSize(width: 1125, height: 2436)) ? true : false

let LNAVIGATION_HEIGHT = iPhoneX ? CGFloat(44+20+24):CGFloat(44+20)

//MARK:字体
var hc_fontThin = { (num : CGFloat) ->  UIFont in
    return  UIFont.init(name: "HelveticaNeue-Thin", size: num)!
}
var hc_fzFontMedium = { (num : CGFloat) ->  UIFont in
    return  UIFont.init(name: "HelveticaNeue-Medium", size: num)!
}
//MARK:色值

//自定义调试信息打印
func HCLog<T>(message : T, file : String = #file, lineNumber : Int = #line) {
    //#if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):line:\(lineNumber)]- \(message)")
    
    //#endif
}

