//
//  PubMessageTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/17.
//  Copyright © 2018年 lvxin. All rights reserved.
//  公告cell

import UIKit
protocol PubMessageTableViewCellDelegate {
    func redMessage(model:newslistModel)
}

class PubMessageTableViewCell: UITableViewCell {
    var delegate : PubMessageTableViewCellDelegate!
    var dataModel :newslistModel!
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var timebtn: UIButton!
    
    @IBOutlet weak var titleLabel: UIButton!
    
    @IBOutlet weak var subTitleLabel: UIButton!
    @IBAction func redBtnClick(_ sender: UIButton) {
        HCLog(message: "查看全文")
        if !(delegate == nil) {
            self.delegate.redMessage(model: dataModel)
        }
    }
    @objc func readGes() {
        HCLog(message: "1212查看全文")
        if !(delegate == nil) {
            self.delegate.redMessage(model: dataModel)
        }
    }
    func setData(model:newslistModel) {

        let ges : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(readGes))
        self.backView.addGestureRecognizer(ges)

        dataModel = model
        if let timeStr = model.createtime {
            let str  = String.hc_getDate_string(dateStr: timeStr)
            self.timebtn .setTitle(str, for: .normal)
        }
        if let title = model.title {
            self.titleLabel.setTitle(title, for: .normal)
        }
        if let subTitle = model.object {
            self.subTitleLabel.setTitle(subTitle, for: .normal)
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
