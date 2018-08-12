
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
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBAction func iconImageTap(_ sender: UITapGestureRecognizer) {
        HCLog(message: "图片点击")
        if !(self.delegate == nil) {
            self.delegate.iconClick()
        }
    }

    @objc func bgClick() {
        HCLog(message: "背景点击")
        if !(self.delegate == nil) {
            self.delegate.iconClick()
        }


    }

    func setData(model : user_getinfoModel) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(bgClick))
        backImageView.addGestureRecognizer(tap)

        if let face = model.face {
            self.iconImageView .setImage_kf(imageName: face, placeholderImage: #imageLiteral(resourceName: "log_persion"))
        }
        if let name = model.name {
            self.nameLabel.text = name
        }
        if let role = model.role {
            self.roleLabel.text = role
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
