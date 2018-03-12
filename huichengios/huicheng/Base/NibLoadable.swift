//
//  NibLoadable.swift
//  huicheng
//
//  Created by lvxin on 2018/3/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import Foundation
protocol NibLoadable {
}

extension NibLoadable where Self : UIView {
    
    static func loadNib(_ nibName : String? = nil) -> UIView{
        debugPrint("\(self)")
        return Bundle.main.loadNibNamed(nibName ?? "\(self)", owner: nil, options: nil)?.first as! UIView

    }
    
}
