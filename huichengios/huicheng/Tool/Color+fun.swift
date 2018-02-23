//
//  Color+fun.swift
//  学记
//
//  Created by lvxin on 2017/10/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 输入16进制返回颜色
    ///
    /// - parameter rgbValue: 16进制颜色
    ///
    /// - returns: UIColor
    static func hc_colorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    /// 输入三色值返回颜色
    ///
    /// - parameter red:   红的
    /// - parameter green: 绿
    /// - parameter blue:  蓝
    /// - parameter alpha: 透明度
    ///
    /// - returns: UIColor
    static func hc_ColorFromInt(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }

}
