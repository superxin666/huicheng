//
//  MineTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//  我的 cell

import UIKit

class MineTableViewCell: UITableViewCell {
    let nameArr = ["备忘录","报销申请","发票申请","我的收款","工作日志",]
    let imageNameArr = [#imageLiteral(resourceName: "备忘录"),#imageLiteral(resourceName: "报销申请"),#imageLiteral(resourceName: "发票申请"),#imageLiteral(resourceName: "我的收款"),#imageLiteral(resourceName: "工作日志")]
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    /// 标题
    var titleStr : String!
    
    func setData(name : String)  {
        self.titleLabel.text = name
        self.iconImageView.image = UIImage(named: name)
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
