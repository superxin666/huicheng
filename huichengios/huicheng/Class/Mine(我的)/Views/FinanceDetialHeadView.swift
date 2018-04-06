//
//  FinanceDetialHeadView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/30.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class FinanceDetialHeadView: UIView,NibLoadable {

    @IBOutlet weak var titleNameLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func setData(name : String) {
        self.titleNameLabel.text = name
    }

}
