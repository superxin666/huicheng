


//
//  WorkFootView.swift
//  huicheng
//
//  Created by lvxin on 2018/8/11.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class WorkFootView: UICollectionReusableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func creatUI() {
        let topLineView = UIView(frame: CGRect(x: 0, y: ip6(10), width: KSCREEN_WIDTH, height: ip6(5)))
        topLineView.backgroundColor = viewBackColor
        self.addSubview(topLineView)
    }

}
