//
//  FamilyTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/10/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let FamilyTableViewCellID = "FamilyTableViewCell_id"
let FamilyTableViewCellH = CGFloat(100)


class FamilyTableViewCell: UITableViewCell {
    @IBOutlet weak var left1Label: UILabel!

    @IBOutlet weak var left2Label: UILabel!
    @IBOutlet weak var left3Label: UILabel!

    @IBOutlet weak var left4Label: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!


    func setData(model : usermanageInfoModel_info2_family) {

        let strName = NSMutableAttributedString(string: "关系：")
        let strName2 = model.relation.getAttributedStr_color(color: .black, fontSzie: 13)
        strName.append(strName2)
        self.left1Label.attributedText = strName

        let strName1 = NSMutableAttributedString(string: "单位：")
        let strName3 = model.work.getAttributedStr_color(color: .black, fontSzie: 13)
        strName1.append(strName3)
        self.left2Label.attributedText = strName1

        let strName4 = NSMutableAttributedString(string: "职位：")
        let strName5 = model.job.getAttributedStr_color(color: .black, fontSzie: 13)
        strName4.append(strName5)
        self.left3Label.attributedText = strName4

        let strName6 = NSMutableAttributedString(string: "联系电话：")
        let strName7 = model.phone.getAttributedStr_color(color: .black, fontSzie: 13)
        strName6.append(strName7)
        self.left4Label.attributedText = strName6


        let strName8 = NSMutableAttributedString(string: "姓名：")
        let strName9 = model.name.getAttributedStr_color(color: .black, fontSzie: 13)
        strName8.append(strName9)
        self.rightLabel.attributedText = strName8



    }

    func setData1(model : usermanageInfoModel_info3) {

        self.left1Label.text = "外语："

        let strName1 = NSMutableAttributedString(string: "英语  级别：")
        let strName3 = model.language_en.getAttributedStr_color(color: .black, fontSzie: 13)
        strName1.append(strName3)
        self.left2Label.attributedText = strName1

        let strName4 = NSMutableAttributedString(string: "日语  级别：")
        let strName5 = model.language_jp.getAttributedStr_color(color: .black, fontSzie: 13)
        strName4.append(strName5)
        self.left3Label.attributedText = strName4

        let strName6 = NSMutableAttributedString(string: "\(model.language_other)  级别：")
        let strName7 = model.languagelevel.getAttributedStr_color(color: .black, fontSzie: 13)
        strName6.append(strName7)
        self.left4Label.attributedText = strName6

        self.rightLabel.text = ""


    }

    func setData2(model : usermanageInfoModel_info3_school) {

        let strName = NSMutableAttributedString(string: "时间：")
        let str = model.begintime + "~" + model.endtime
        let strName2 = str.getAttributedStr_color(color: .black, fontSzie: 13)
        strName.append(strName2)
        self.left1Label.attributedText = strName

        let strName1 = NSMutableAttributedString(string: "学校：")
        let strName3 = model.school.getAttributedStr_color(color: .black, fontSzie: 13)
        strName1.append(strName3)
        self.left2Label.attributedText = strName1

        let strName4 = NSMutableAttributedString(string: "专业：")
        let strName5 = model.project.getAttributedStr_color(color: .black, fontSzie: 13)
        strName4.append(strName5)
        self.left3Label.attributedText = strName4

        let strName6 = NSMutableAttributedString(string: "学历：")
        let strName7 = model.diploma.getAttributedStr_color(color: .black, fontSzie: 13)
        strName6.append(strName7)
        self.left4Label.attributedText = strName6


        self.rightLabel.text = ""



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
