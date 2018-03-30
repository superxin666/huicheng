//
//  SearchStateTableViewCell.swift
//  huicheng
//
//  Created by lvxin on 2018/3/30.
//  Copyright © 2018年 lvxin. All rights reserved.
//  搜索页面  状态选择

import UIKit

class SearchStateTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    var nameArr = ["未审核","已审核","审核驳回","已支付",]
    
    @IBOutlet weak var pickView: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.pickView.delegate = self
        self.pickView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nameArr.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
   
    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        let str = nameArr[row]
//        let label = UILabel(frame: CGRect(x: 0, y: 15, width: 100, height: 20))
//        label.text = str
//        label.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x666666)
//        return label
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let str = nameArr[row]
        let label = UILabel(frame: CGRect(x: 0, y: 15, width: 100, height: 20))
        label.text = str
        label.textColor = UIColor.hc_colorFromRGB(rgbValue: 0x666666)
        label.font = hc_fontThin(13)
        return label
    }
    
}
