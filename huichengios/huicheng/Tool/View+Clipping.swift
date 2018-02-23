//
//  View+Clipping.swift
//  学记
//
//  Created by lvxin on 2017/10/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 给视图添加边框
    ///
    /// - parameter width: 宽度
    /// - parameter color: 颜色
    func xj_makeBorderWithBorderWidth(width:CGFloat , color:UIColor ){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    /// 给视图添加边框和圆角
    ///
    /// - parameter width:  宽度
    /// - parameter color:  颜色
    /// - parameter radius: 圆角角度
    func xj_makeBorderAndRadius(width:CGFloat , color:UIColor ,radius:CGFloat){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
        
    }
    
    /// 添加圆角
    ///
    /// - parameter radius: 角度
    func xj_makeRadius(radius:CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    
    /// 圆
    func xj_makeRound() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
    
}
