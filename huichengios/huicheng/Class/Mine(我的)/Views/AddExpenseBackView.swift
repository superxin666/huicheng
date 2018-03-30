//
//  AddExpenseBackView.swift
//  huicheng
//
//  Created by lvxin on 2018/3/29.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class AddExpenseBackView: UIView,NibLoadable,UIPickerViewDelegate ,UIPickerViewDataSource{
    var dataArr : [expense_gettypeModel] = []
    @IBOutlet weak var pickView: UIPickerView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var moneyField: UITextField!
    
    @IBOutlet weak var numField: UITextField!
    /// 报销类型
    var type : Int!
    
    /// 报销金额
    var money : Int!
    
    /// 单票数量
    var num : Int!
    
    
    
    @IBAction func endTextFiled(_ sender: UITextField) {
        if sender.tag == 0 {
            //金额
            money = Int(sender.text!)
        } else {
            //数据个数
            num = Int(sender.text!)
        }
    }
    
    
    func setData()  {
        //标题
        self.titleLabel.text = "1、发票的付款单位为：北京市惠诚律师事务所，不得简写。\n2、发票必须为当年的票据"
        //展示第一个数据的 提示
        if dataArr.count > 0  {
            let model : expense_gettypeModel = dataArr[0]
            if let str = model.note {
                self.infoLabel.text = str
            }
            self.type = model.id
        }

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return dataArr.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row < self.dataArr.count {
            let model : expense_gettypeModel = dataArr[row]
            if let str = model.note {
                self.infoLabel.text = str
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var str = ""
        if row < self.dataArr.count {
            let model = self.dataArr[row]
            str = model.name
            type = model.id
        }
        return str
    }
    override func awakeFromNib() {
        self.pickView.delegate = self
        self.pickView.dataSource = self
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
