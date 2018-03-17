//
//  NibLoadableCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/17.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import Foundation
protocol NibLoadableCell {
    
}
extension NibLoadableCell where Self : UITableViewCell {
    
    static func loadNib(_ nibName : String? = nil) -> Self{
        debugPrint("\(self)")
        return Bundle.main.loadNibNamed(nibName ?? "\(self)", owner: nil, options: nil)?.first as! Self
        
    }
    
}
