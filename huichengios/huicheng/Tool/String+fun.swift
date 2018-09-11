//
//  String+fun.swift
//  学记
//
//  Created by lvxin on 2017/10/30.
//  Copyright © 2017年 lvxin. All rights reserved.
//

import UIKit


extension String {
    
    /// 测文字的高度
    ///
    /// - parameter width: 宽度限制
    /// - parameter font:  字体
    ///
    /// - returns: 高度
    func hc_heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }
    
    
    func hc_widthWithConstrainedWidth(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width:  CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.width
    }
    
    // MARK: 公共部分
    /// 获取版本号
    ///
    /// - returns: 版本号
    func hc_getAppVersion() -> String  {
        let infoDict = Bundle.main.infoDictionary
        if let info = infoDict {
            let appVersion = info["CFBundleShortVersionString"] as! String!
            return ("ios" + appVersion!)
        } else {
            return ""
        }
    }
    
    
//    func getToken_RSA() -> String {
////        let token:String!  = LoginModelMapper.getToken()
//        //        KFBLog(message: "token   "+token)
//        //        let token_rsa = RSA.encryptString(token, publicKey: pubkey)
//        return token
//        //        return "eyJ0b2tlbiI6IjE0Zjk0ODU4MjI0YzQwMGZmMjQyNzY2MmY1ZjI0MTNjIiwic2VjcmV0IjoiN2FlMTcxY2NiM2M4NjIyN2E1ZGZkOGNiMTEzZDA0MmUifQ=="
//    }
    
    /// 判断是否为空字符串
    ///
    /// - parameter str: 字符串
    ///
    /// - returns: 是否
    
    static func hc_isStr(str : String?) -> Bool {
        if (str == nil)  {
            return false
        } else {
            if ((str?.count)! < 0){
                return false
            } else {
                return true
            }
        }
    }
    
    
    /// 判断是否是手机号
    ///
    /// - parameter phoneNum: 手机号
    ///
    /// - returns: 是或者不是
    static func hc_isMobileNumber(phoneNum : String) -> Bool {
        let predicateStr = "^((13[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$"
        let currObject = phoneNum
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: currObject)
    }
    
    
    
    /// 时间格式转换
    ///
    /// - Parameters:
    ///   - dateStr: 时间字符串
    ///   - style: 样式选择
    /// - Returns: 转换后的时间字符串
    static func hc_getDate_style1(dateStr : String,style:Int) -> String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: dateStr)
        
        var  styleSty = ""
        switch style {
        case 0:
            styleSty = "MM.dd HH:mm"
        case 1:
            styleSty = "HH:mm"
        case 2:
            styleSty = "HH:mm"
        case 3:
            styleSty = "yyyy-MM-dd HH:mm:ss"
        case 4:
            styleSty = "yyyy-MM-dd"


        default:
            styleSty = "yyyy.MM.dd HH:mm"
        }
        
        let dfmatter2 = DateFormatter()
        dfmatter2.dateFormat = styleSty
        return dfmatter2.string(from: date!)
    }
    
    
    static func hc_getDate(date : Date) -> String {

        let dfmatter2 = DateFormatter()
        dfmatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dfmatter2.string(from: date)
    }
    
    static func hc_getDate_string(dateStr : String) -> String {
        HCLog(message: dateStr)
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: dateStr)
//        return  dfmatter.string(from: date!)

        let dfmatter2 = DateFormatter()
        dfmatter2.dateFormat="yyyy-MM-dd HH:mm"
        return dfmatter2.string(from: date!)
    }


    static func hc_getDate_string0(dateStr : String) -> String {
        HCLog(message: dateStr)
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: dateStr)
        //        return  dfmatter.string(from: date!)

        let dfmatter2 = DateFormatter()
        dfmatter2.dateFormat="yyyy-MM-dd HH:mm:00"
        return dfmatter2.string(from: date!)
    }

    
    
    /// 获取当前时间
    ///
    /// - Returns: <#return value description#>
    static func getDateNow()->String  {
        let date  = Date()
        let dfmatter2 = DateFormatter()
        dfmatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dfmatter2.string(from: date)
    }

    /// 将str转为attributeStr
    ///
    /// - Parameters:
    ///   - color: 字体颜色
    ///   - fontSzie: 字体
    /// - Returns: <#return value description#>
    func getAttributedStr_color(color : UIColor,fontSzie : Int) ->(NSMutableAttributedString) {
         let attributeStr = NSMutableAttributedString(string: self)
         let range : NSRange = NSRange.init(location: 0, length: self.count)
        attributeStr.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        attributeStr.addAttribute(NSAttributedStringKey.font, value: hc_fzFontMedium(ip6(fontSzie)), range: range)
         return attributeStr
    }

    func containsEmoji() -> Bool {
        for scalar in unicodeScalars{
            switch scalar.value{
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    

}

