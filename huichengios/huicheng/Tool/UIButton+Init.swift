//
//  UIButton+Init.swift
//  xueji
//
//  Created by lvxin on 2017/11/20.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit

extension UIButton {

    
    /// 初始化标题按钮 只有标题
    ///
    /// - Parameters:
    ///   - title_normal: 标题
    ///   - title_selected: 选中状态 标题
    ///   - fream: 尺寸
    ///   - backgroundColor: 背景颜色
    ///   - textColor: 文字颜色
    ///   - fontSize: 字体大小 适配前
    ///   - textAlignment:字体偏转
    ///   - selector: 点击事件
    ///   - vc: 拥有者
    /// - Returns: 按钮
    static func getBtn_titleStyle(title_normal : String,title_selected : String,fream : CGRect,backgroundColor : UIColor,textColor : UIColor,fontSize : CGFloat,textAlignment : NSTextAlignment,selector : Selector,vc : Any,tag : Int) ->(UIButton)  {
        let btn = UIButton(type: .custom)
        btn.frame = fream
        btn.tag = tag
        btn.setTitle(title_normal, for: .normal)
        btn.setTitle(title_selected, for: .selected)
        btn.backgroundColor = backgroundColor
        btn.titleLabel?.font = hc_fzFontMedium(ip6(Int(fontSize)))
        btn.setTitleColor(textColor, for: .normal)
        btn.titleLabel?.textAlignment = textAlignment
        btn.addTarget(vc, action: selector, for: .touchUpInside)
        return btn
    }
    
    
    /// 初始化图片按钮 只有图片
    ///
    /// - Parameters:
    ///   - image_normal: 图片
    ///   - image_selected: 选中图片
    ///   - fream: 尺寸
    ///   - selector: 点击事件
    ///   - vc: 拥有者
    ///   - tag: tag
    /// - Returns: 按钮
    static func getBtn_picStyle(image_normal : UIImage,image_selected : UIImage,fream : CGRect,selector : Selector,vc : Any,tag : Int) ->(UIButton)  {
        let btn = UIButton(type: .custom)
        btn.frame = fream
        btn.tag = tag
        btn.setImage(image_normal, for: .normal)
        btn.setImage(image_selected, for: .selected)
        btn.addTarget(vc, action: selector, for: .touchUpInside)
        return btn
    }
    
    
    /// 初始化按钮 文字 图片
    ///
    /// - Parameters:
    ///   - title_normal: 标题
    ///   - image_normal: 图片
    ///   - fream: 尺寸
    ///   - imageEdgeInsets: 图片尺寸
    ///   - backgroundColor: 背景颜色
    ///   - textColor: 文字颜色
    ///   - fontSize: 字体大小
    ///   - textAlignment: 文字位置
    ///   - selector: 点击事件
    ///   - vc: 拥有者
    ///   - tag: tag
    /// - Returns: 按钮
    static func getBtn_title_imageStyle(title_normal : String,image_normal : UIImage,fream : CGRect,imageEdgeInsets : UIEdgeInsets,backgroundColor : UIColor,textColor : UIColor,fontSize : CGFloat,textAlignment : NSTextAlignment,selector : Selector,vc : Any,tag : Int) ->(UIButton)  {
        let btn = UIButton(type: .custom)
        btn.frame = fream
        btn.imageEdgeInsets = imageEdgeInsets
        btn.tag = tag
        btn.setTitle(title_normal, for: .normal)
        btn.setImage(image_normal, for: .normal)
        btn.backgroundColor = backgroundColor
        btn.titleLabel?.font = hc_fzFontMedium(ip6(Int(fontSize)))
        btn.setTitleColor(textColor, for: .normal)
        btn.titleLabel?.textAlignment = textAlignment
        btn.addTarget(vc, action: selector, for: .touchUpInside)
        return btn
    }
    
}
