//
//  UILabel+Init.swift
//  xueji
//
//  Created by lvxin on 2017/11/22.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit

extension UILabel {

    static func getLabel(fream : CGRect,fontSize : CGFloat,text : String,textColor:UIColor,textAlignment : NSTextAlignment) ->(UILabel) {
        let label : UILabel = UILabel()
        label.frame  = fream
        label.font = hc_fzFontMedium(ip6(Int(fontSize)))
        label.text = text
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }
    
    static func getLabel_AttributedTitle(fream : CGRect,fontSize : CGFloat,text : NSMutableAttributedString,textColor:UIColor,textAlignment : NSTextAlignment) ->(UILabel) {
        let label : UILabel = UILabel()
        label.frame  = fream
        label.font = hc_fzFontMedium(ip6(Int(fontSize)))
        label.textColor = textColor
        label.attributedText = text
        label.textAlignment = textAlignment
        return label
    }
}
