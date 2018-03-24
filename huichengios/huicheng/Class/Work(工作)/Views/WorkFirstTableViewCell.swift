//
//  WorkFirstTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol WorkFirstTableViewCellDelegate {
    func  workFirstTableViewCellBtnClick(tag : Int,rowNum:Int)
}
class WorkFirstTableViewCell: UITableViewCell {
    var delegate  : WorkFirstTableViewCellDelegate!
    let titleStrArr = ["案件","合同","签章","财务","其他"]
    
    let labelNameAr0 = ["案件登记","生成合同","案件查询","利益冲突查询",]
    let labelNameAr1 = ["合同管理","结案申请","合同审核","结案审核","审核进度查询"]
    let labelNameAr2 = ["函件管理","诉讼函","民事函","刑事函","自定义函","签章进度查询","签章审核"]
    let labelNameAr3 = ["收款登记","收款审核","支付收款","支付审核","报销审核","发票审核","签章审核"]
    let labelNameAr4 = ["会议室预约","发布公告","共享模板",]
  
    var row : Int!
    
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var label1: UILabel!
    
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var label2: UILabel!
    
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var label4: UILabel!
    
    @IBOutlet weak var view5 : UIView!
    @IBOutlet weak var imageView5 : UIImageView!
    @IBOutlet weak var label5 : UILabel!
    
    @IBOutlet weak var view6 : UIView!
    @IBOutlet weak var imageView6 : UIImageView!
    @IBOutlet weak var label6 : UILabel!
    
    @IBOutlet weak var view7 : UIView!
    @IBOutlet weak var imageView7 : UIImageView!
    @IBOutlet weak var label7 : UILabel!
    
    @IBOutlet weak var view8 : UIView!
    @IBOutlet weak var imageView8 : UIImageView!
    @IBOutlet weak var label8 : UILabel!
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tapClick(sender:)))
        view1.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tapClick(sender:)))
        view2.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(tapClick(sender:)))
        view3.addGestureRecognizer(tap3)
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(tapClick(sender:)))
        view4.addGestureRecognizer(tap4)
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(tapClick(sender:)))
        view5.addGestureRecognizer(tap5)
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(tapClick(sender:)))
        view6.addGestureRecognizer(tap6)
        let tap7 = UITapGestureRecognizer(target: self, action: #selector(tapClick(sender:)))
        view7.addGestureRecognizer(tap7)
        let tap8 = UITapGestureRecognizer(target: self, action: #selector(tapClick(sender:)))
        view8.addGestureRecognizer(tap8)
        

    }
    
    @objc func tapClick(sender : UITapGestureRecognizer) {
        let view = sender.view
        if (self.delegate != nil) {
            self.delegate.workFirstTableViewCellBtnClick(tag: (view?.tag)!,rowNum: row)
        }
    }
    func setData(rowNum : Int) {
        row = rowNum
        self.titleLabel.text = titleStrArr[rowNum]
        switch rowNum {
        case 0:
            self.view5.isHidden = true
            self.view6.isHidden = true
            self.view7.isHidden = true
            self.view8.isHidden = true
    
            self.label1 .text = self.labelNameAr0[0]
            self.label2 .text = self.labelNameAr0[1]
            self.label3 .text = self.labelNameAr0[2]
            self.label4 .text = self.labelNameAr0[3]
        case 1:
            self.view6.isHidden = true
            self.view7.isHidden = true
            self.view8.isHidden = true
            
            self.label1 .text = self.labelNameAr1[0]
            self.label2 .text = self.labelNameAr1[1]
            self.label3 .text = self.labelNameAr1[2]
            self.label4 .text = self.labelNameAr1[3]
            self.label5 .text = self.labelNameAr1[4]
        case 2:
    
            self.view8.isHidden = true
            
            self.label1 .text = self.labelNameAr2[0]
            self.label2 .text = self.labelNameAr2[1]
            self.label3 .text = self.labelNameAr2[2]
            self.label4 .text = self.labelNameAr2[3]
            self.label5 .text = self.labelNameAr2[4]
            self.label6 .text = self.labelNameAr2[5]
            self.label7 .text = self.labelNameAr2[6]

        case 3:
            self.view8.isHidden = true
            
            self.label1 .text = self.labelNameAr3[0]
            self.label2 .text = self.labelNameAr3[1]
            self.label3 .text = self.labelNameAr3[2]
            self.label4 .text = self.labelNameAr3[3]
            self.label5 .text = self.labelNameAr3[4]
            self.label6 .text = self.labelNameAr3[5]
            self.label7 .text = self.labelNameAr3[6]
        case 4:
            self.view4.isHidden = true
            self.view5.isHidden = true
            self.view6.isHidden = true
            self.view7.isHidden = true
            self.view8.isHidden = true
            
            self.label1 .text = self.labelNameAr4[0]
            self.label2 .text = self.labelNameAr4[1]
            self.label3 .text = self.labelNameAr4[2]

        default:
            break
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
