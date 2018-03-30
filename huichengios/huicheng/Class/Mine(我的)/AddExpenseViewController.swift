//
//  AddExpenseViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/29.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加报销申请

import UIKit
typealias AddExpenseViewControllerBlock = ()->()
enum AddExpenseViewController_type {
    case add_type,detaile_type
}

class AddExpenseViewController: BaseViewController ,MineRequestVCDelegate{
    var backView : AddExpenseBackView!
    var request : MineRequestVC = MineRequestVC()
    var dataArr : [expense_gettypeModel] = []
    
    
    var type: AddExpenseViewController_type!
    var expenseId : Int!
    var sureStateBlock : AddExpenseViewControllerBlock!
    
    // MARK: - life cicle
    override func viewWillLayoutSubviews() {
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(LNAVIGATION_HEIGHT)
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigation_title_fontsize(name: "报销申请", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        request.delegate = self
        backView = AddExpenseBackView.loadNib()
        self.view.addSubview(backView)
        
        if self.type == .add_type {
            //获取报销类型
            self.navigationBar_rightBtn_title(name: "确定")
            request.expense_gettypeRequest()
        } else {
            //报销详情
            request.expense_getinfoRequest(id: expenseId)

        }

    }
    // MARK: - delegate
    func requestSucceed(data: Any, type: MineRequestVC_enum) {
        if type == .expense_save {
            //保存
            let model : CodeData = data as! CodeData
            if model.code == 1 {
                self.sureStateBlock()
                self.navigationController?.popViewController(animated: true)
            }
            
            
        } else if type == .expense_gettype{
            //type 列表
            let arr = data as! [expense_gettypeModel]
            if dataArr.count > 0 {
                self.dataArr.removeAll()
            }
            self.dataArr = arr
            backView.dataArr = self.dataArr
            backView.setData()
            backView.pickView.reloadAllComponents()
            
        } else if type == .expense_getinfo{
            //详情
            let model : expense_getinfoModel = data as! expense_getinfoModel
            backView.setDataDetail(model: model)
            backView.pickView.reloadAllComponents()

        }
    }
    func requestFail() {
        
    }
    // MARK: - response
    override func navigationRightBtnClick() {
        HCLog(message: "确定")
        if backView.moneyField.isFirstResponder {
            backView.moneyField.resignFirstResponder()
        }
        if backView.numField.isFirstResponder {
            backView.numField.resignFirstResponder()
        }
        guard let type = backView.type else {
            SVPMessageShow.showErro(infoStr: "请选择报销类型")
            return
        }
        guard let money = backView.money else {
            SVPMessageShow.showErro(infoStr: "请输入报销金额")
            return
        }
        guard let num = backView.num else {
            SVPMessageShow.showErro(infoStr: "请输入票据数量")
            return
        }
        request.expense_saveRequest(t: type, n: money, m:  num)
        
    }
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
