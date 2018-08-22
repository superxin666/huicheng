//
//  WorlkHeadView.swift
//  huicheng
//
//  Created by lvxin on 2018/8/11.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class WorlkHeadView: UICollectionReusableView {

    var nameLable : UILabel!


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpUI() {
        let lineView = UIView(frame: CGRect(x: ip6(15), y: ip6(23), width: ip6(3), height: ip6(10)))
        lineView.backgroundColor = UIColor.hc_colorFromRGB(rgbValue: 0xFF6900)
        self.addSubview(lineView)

        nameLable = UILabel(frame: CGRect(x: ip6(25), y: ip6(18), width: ip6(100), height: ip6(20)))

        nameLable.font = hc_fzFontMedium(16)
        nameLable.textColor = darkblueColor
        nameLable.textAlignment = .left
        self.addSubview(nameLable)


    }

    func creatUI(name : String,sectionNum : Int) {
 
        HCLog(message: name)
        nameLable.text = name


    }

}
