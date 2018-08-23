//
//  OptionView.swift
//  huicheng
//
//  Created by lvxin on 2018/4/13.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
protocol OptionViewDelgate {
    func optionSure(idStr : String,titleStr : String,noteStr : String,pickTag : Int)

}

enum OptionViewType {

    //搜索中状态  报销  接受对象      发票列表    我的收款  案件添加   案件律师   案件部门 发票状态
    case searchState,Object,invoice_getlist,finance, caseType,caseUser,caseDep,invoiceState,crtInfo,expense_gettype,share_type
}
class OptionView: UIView,NibLoadable,UIPickerViewDelegate, UIPickerViewDataSource {
    var delegate : OptionViewDelgate!

    /// 当前id
    var cuurectID : String = ""
    
    /// 当前标题
    var currectStr : String = ""

    var currectNoteStr : String = ""

    
    /// 类型 默认搜索
    var type :OptionViewType = .searchState
    //搜索 报销
    //0 1 2 3
    var nameArr = ["未审核","已审核","审核驳回","已支付",]
    var idArr = ["0","1","2","3",]


    /// 0-不限;1-诉讼案件;2-非诉案件;3-刑事案件;4-法律顾问;5-采购合同;6-资质文件;
    var shareNameArr = ["不限","诉讼案件","非诉案件","刑事案件","法律顾问","采购合同","资质文件"]
    var shareIdArr = ["0","1","2","3","4","5","6"]


    //接受对象
    //数组
    var dataArr : [getobjectlistModel] = []

    //发票
    var nameArr_invoice = ["未审核","已审核","审核驳回","已寄送",]
    var idArr_invoice = ["0","1","2","3",]
    // 我的收款
    var nameArr_finance = ["未支付","已支付",]
    var idArr_finance = ["1","3",]


    // 发票状态
    var nameArr_invoiceState = ["未开","已开",]
    var idArr_invoiceState = ["0","1",]

    //律师
    var data_userlistArr : [userlistModel] = []
    var data_userlistArr1 : [userlistModel] = []
    var data_userlistArr2 : [userlistModel] = []
    //部门列表
    var data_departArr : [departmentModel] = []
    //案件类型
    var data_casetypeArr : [casetypeModel] = []

    var data_expenseArr : [expense_gettypeModel] = []

    var currectexpense : expense_gettypeModel!


    var crt : [String] = []


    func setData_crt(tagNum : Int,dataArr : [String]) {


        crt = dataArr
        self.pickView.tag = tagNum
        type = .crtInfo
        self.pickView.reloadAllComponents()

    }

    func setData()  {
        self.type = .searchState
        self.pickView.reloadAllComponents()
    }

    func setData_share() {
        self.type = .share_type
        self.pickView.reloadAllComponents()
    }

    func setData_dep(dataArr : [Any],tagNum : Int)  {
        self.pickView.tag = tagNum

        self.type = .caseDep
        data_departArr = dataArr as! [departmentModel]
        self.pickView.reloadAllComponents()
    }


    func setData_casetypeonly(dataArr : [Any],tagNum : Int)  {
         self.pickView.tag = tagNum

        self.type = .caseType
        data_casetypeArr = dataArr as! [casetypeModel]
        self.pickView.reloadAllComponents()
    }



    func setDatainvoiceState()  {
        self.type = .invoiceState
        self.pickView.reloadAllComponents()
    }

    func setDataExpensive(dataArr : [expense_gettypeModel]) {
        self.type = .expense_gettype
        self.data_expenseArr = dataArr
        self.pickView.reloadAllComponents()
    }


    func setData_case(dataArr : [Any],indexPath : IndexPath) {
        self.pickView.tag = indexPath.row

        if indexPath.row == 0 {
            self.type = .caseType
            data_casetypeArr = dataArr as! [casetypeModel]
        } else if indexPath.row == 3 {
            self.type = .caseUser
            data_userlistArr = dataArr as! [userlistModel]
        } else if indexPath.row == 4 {
            self.type = .caseDep
            data_departArr = dataArr as! [departmentModel]
        } else if indexPath.row == 5 {
            self.type = .caseUser
            data_userlistArr = dataArr as! [userlistModel]
        } else {
            self.type = .caseUser
            data_userlistArr = dataArr as! [userlistModel]
        }
        self.pickView.reloadAllComponents()
    }


    func setData_deal(dataArr : [Any])  {
        self.type = .caseUser
        data_userlistArr = dataArr as! [userlistModel]
        self.pickView.reloadAllComponents()
    }

    func setData_share(dataArr : [Any])  {
        self.type = .caseType
        data_casetypeArr = dataArr as! [casetypeModel]
        self.pickView.reloadAllComponents()
    }

    func setData_bank(dataArr : [Any])  {
        self.type = .caseDep
        data_departArr = dataArr as! [departmentModel]
        self.pickView.reloadAllComponents()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if type == .searchState {
            return nameArr.count
            
        } else if type == .invoice_getlist {
            return nameArr_invoice.count
            
        }  else if type == .finance {
            
            return nameArr_finance.count
            
        } else if type == .Object {
            
            return dataArr.count
        } else if type == .caseType {
            return self.data_casetypeArr.count
        }else if type == .caseDep {
            return self.data_departArr.count
        } else if type == .caseUser {
            return self.data_userlistArr.count
        } else if type == .invoiceState{
            return self.nameArr_invoiceState.count
        } else if type == .crtInfo {
            return self.crt.count
        } else if type == .expense_gettype {
            return self.data_expenseArr.count
        } else if type == .share_type {
            return self.shareNameArr.count
        }    else {
            return 0
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //显示
        var titleStr = ""
        if type == .searchState {
            //发票
            titleStr = nameArr[row]
            cuurectID = idArr[row]
            currectStr = titleStr
        } else if type == .invoice_getlist {
            titleStr = nameArr[row]
            cuurectID = idArr[row]
            currectStr = titleStr
        } else if type == .Object {
            //接受对象

            let model = dataArr[row]
            titleStr = model.name!
            cuurectID = "\(model.id!)"
            currectStr = titleStr
        } else if type == .finance{
            //收款
            titleStr = nameArr_finance[row]
            cuurectID = idArr_finance[row]
            currectStr = titleStr
        }else if type == .caseType{
            //案件
            let model : casetypeModel = self.data_casetypeArr[row]
            titleStr = model.name
            cuurectID = "\(model.id!)"
            currectStr = titleStr
        } else if type == .caseDep {
            let model : departmentModel = self.data_departArr[row]
            titleStr = model.name
            cuurectID = "\(model.id!)"
            currectStr = titleStr
        } else if type == .caseUser {
            let model : userlistModel = self.data_userlistArr[row]
            titleStr = model.name
            cuurectID = "\(model.id!)"
            currectStr = titleStr
        } else if type == .invoiceState {
            titleStr = nameArr_invoiceState[row]
            cuurectID = idArr_invoiceState[row]
            currectStr = titleStr
        } else if type == .crtInfo {

            titleStr = crt[row]
            currectStr = titleStr
            cuurectID = ""

        } else if type == .expense_gettype {
            let model : expense_gettypeModel = self.data_expenseArr[row]

            titleStr = model.name
            cuurectID = "\(model.id!)"
            currectStr = titleStr
            if let str = model.note {
                currectNoteStr = model.note

            }
        } else if type == .share_type {

            titleStr = shareNameArr[row]
            cuurectID = shareIdArr[row]
            currectStr = titleStr
        }


        let label = UILabel(frame: CGRect(x: 0, y: 15, width: pickerView.frame.width, height: ip6(40)))
        label.text = titleStr
        label.textColor = .black
        label.font = hc_fontThin(20)
        label.textAlignment = .center
        return label
    }

    @IBOutlet weak var pickView: UIPickerView!

    @IBAction func sureClick(_ sender: UIButton) {

        if let delegate = self.delegate {
            HCLog(message: self.pickView.tag)
            delegate.optionSure(idStr: cuurectID, titleStr: currectStr,noteStr : currectNoteStr, pickTag: self.pickView.tag)
        }


    }

    override func awakeFromNib() {
        self.pickView.delegate = self
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


}
