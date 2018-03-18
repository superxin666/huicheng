
//
//  MineHeadView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol MineHeadViewDelegate {
    /// 头像点击
    func iconClick()
}
class MineHeadView: UIView,NibLoadable {
    var delegate : MineHeadViewDelegate!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBAction func iconImageTap(_ sender: UITapGestureRecognizer) {
        HCLog(message: "图片点击")
        if !(self.delegate == nil) {
            self.delegate.iconClick()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
