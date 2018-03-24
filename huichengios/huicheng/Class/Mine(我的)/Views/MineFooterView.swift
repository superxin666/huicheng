//
//  MineFooterView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol MineFooterViewDelegate {
    /// 点击
    func viewTap()
}
class MineFooterView: UIView,NibLoadable {
    var delegate :MineFooterViewDelegate!
    

    @IBOutlet weak var backView: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClik))
        self.backView.addGestureRecognizer(tap)
    }
    
    @objc func tapClik() {
        self.delegate.viewTap()
    }

}
