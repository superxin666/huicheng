//
//  SearchViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/30.
//  Copyright © 2018年 lvxin. All rights reserved.
//  搜索

import UIKit
typealias SearchViewControllerBlock_expense = (_ stateId : String)->()
typealias SearchViewControllerBlock_work = (_ titleStr : String,_ personStr : String,_ StartTimeStr : String,_ endTimeStr : String)->()
typealias SearchViewControllerBlock_finance = (_ noStr : String,_ nStr : String,_ sStr : String,_ stStr : String,_ etStr : String)->()
typealias SearchViewControllerBlock_caselsit = (_ stStr : String,_ etStr : String)->()
enum SearchViewController_type {

    //发票申请           收款记录       工作日志      发票列表         案件查询
    case expense_type, finance_type , work_type ,invoice_getlist,caselsit_type

}
let Searchcell_finance_typeID = "Searchcell_finance_type_id"
class SearchViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate,DatePickViewDelegate {
    /// 列表
    let mainTabelView : UITableView = UITableView()
//    类型
    var type : SearchViewController_type!
//   行数
    var rowNum : Int!
    
    /// 选择类型 block
    var sureStateBlock : SearchViewControllerBlock_expense!
    
    /// 工作日志
    var sureWorkBlock : SearchViewControllerBlock_work!
    
    /// 我都收款
    var sureFinanceBlock : SearchViewControllerBlock_finance!
    
    /// 案件查询
    var sureCaselsitBlock : SearchViewControllerBlock_caselsit!

    /// 状态cell
    var stateCell : SearchStateTableViewCell!
    
    /// 标题
    var titleCell : TitleTableViewCell!
    
    /// 发布人
    var persionCell : SearchPersionTableViewCell!
    
    
    /// 时间
    var startTimeCell : endTimeTableViewCell!
    var endTimeCell : endTimeTableViewCell!
    /// 开始时间
    var startTimeStr : String = ""
    /// 结束时间
    var endTimeStr : String = ""
    /// 时间
    var timeView : DatePickView = DatePickView.loadNib()
    
    // MARK: - life
    override func viewWillLayoutSubviews() {
        mainTabelView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        if type == .expense_type {
            self.navigation_title_fontsize(name: "报销查询", fontsize: 18)
            rowNum = 1
        } else if  type == .finance_type{
            self.navigation_title_fontsize(name: "收款查询", fontsize: 18)
            rowNum = 5
        } else if type == .work_type{
            self.navigation_title_fontsize(name: "公告查询", fontsize: 18)
            rowNum = 4
        } else if type == .invoice_getlist{
            self.navigation_title_fontsize(name: "发票查询", fontsize: 18)
            rowNum = 1
        }else if type == .caselsit_type{
            self.navigation_title_fontsize(name: "案件查询", fontsize: 18)
            rowNum = 2
        }
        self.navigationBar_rightBtn_title(name: "确定")
        self.creatUI()
    }
    // MARK: - UI
    func creatUI() {
        mainTabelView.backgroundColor = UIColor.clear
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.backgroundView?.backgroundColor = .clear
        if type == .expense_type || type == .invoice_getlist {
            mainTabelView.register(UINib.init(nibName: "SearchStateTableViewCell", bundle: nil), forCellReuseIdentifier: SearchStateTableViewCellID)
        } else if type == .finance_type {
            
            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "SearchPersionTableViewCell", bundle: nil), forCellReuseIdentifier: SearchPersionTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
            mainTabelView.register(UINib.init(nibName: "SearchStateTableViewCell", bundle: nil), forCellReuseIdentifier: SearchStateTableViewCellID)
        } else if type == .work_type {
            mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "SearchPersionTableViewCell", bundle: nil), forCellReuseIdentifier: SearchPersionTableViewCellID)
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
            
            
        }else if type == .caselsit_type {
            mainTabelView.register(UINib.init(nibName: "endTimeTableViewCell", bundle: nil), forCellReuseIdentifier: endTimeTableViewCellid)
        }
        self.view.addSubview(mainTabelView)
    }
    
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNum
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == .expense_type {
            stateCell  = tableView.dequeueReusableCell(withIdentifier: SearchStateTableViewCellID, for: indexPath) as! SearchStateTableViewCell
            stateCell.type = .searchState
            stateCell.setData_searchState(titleStr: "状态")
            return stateCell
        } else if type == .invoice_getlist{
            stateCell  = tableView.dequeueReusableCell(withIdentifier: SearchStateTableViewCellID, for: indexPath) as! SearchStateTableViewCell
            stateCell.type = .searchState
            stateCell.setData_searchState(titleStr: "状态")
            return stateCell


        } else if type == .finance_type{
            //我都收款
            
            if indexPath.row == 0 {
    
                titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                //交款人
                titleCell.setData_search(titleStr: "交款人")
                return titleCell
            } else if indexPath.row == 1 {

                //合同编号
                persionCell = tableView.dequeueReusableCell(withIdentifier: SearchPersionTableViewCellID, for: indexPath) as! SearchPersionTableViewCell
                persionCell.setData(titleStr: "合同编号", fieldTag: 1)
                return persionCell

            } else if indexPath.row == 2 {
                //开始时间
                startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                startTimeCell.setData(titleStr: "开始时间", tag: 0)
                
                return startTimeCell
            } else if indexPath.row == 3 {
                //结束时间
                endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                endTimeCell.setData(titleStr: "结束时间", tag: 1)
                return endTimeCell
            } else {
                //状态
                stateCell  = tableView.dequeueReusableCell(withIdentifier: SearchStateTableViewCellID, for: indexPath) as! SearchStateTableViewCell
                stateCell.type = .finance
                stateCell.setData_searchState(titleStr: "状态")
                return stateCell
            }
            
            
        } else if type == .work_type{
            //公告搜索
            if indexPath.row == 0 {
                titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
                //标题
                titleCell.setData_search(titleStr: "标题")
                return titleCell
                
            } else if indexPath.row == 1 {
                //发布人
                persionCell = tableView.dequeueReusableCell(withIdentifier: SearchPersionTableViewCellID, for: indexPath) as! SearchPersionTableViewCell
                persionCell.setData(titleStr: "发布人", fieldTag: 1)
                return persionCell
                
            } else if indexPath.row == 2 {
                //开始时间
                startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                startTimeCell.setData(titleStr: "开始时间", tag: 0)
      
                return startTimeCell
                
            } else {
                //结束时间
                endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                endTimeCell.setData(titleStr: "结束时间", tag: 1)
                return endTimeCell
            }
            
        }else if type == .caselsit_type{
            //公告搜索
            if indexPath.row == 0 {
                //开始时间
                startTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                startTimeCell.setData(titleStr: "开始时间", tag: 0)
                return startTimeCell

            } else {
                //结束时间
                endTimeCell = tableView.dequeueReusableCell(withIdentifier: endTimeTableViewCellid, for: indexPath) as! endTimeTableViewCell
                endTimeCell.setData(titleStr: "结束时间", tag: 1)
                return endTimeCell

            }

        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .work_type {
            if indexPath.row == 2 {
                //开始时间
                self.showTime_start()
            } else {
                //结束时间
                self.showTime_end()
            }
        } else if type == .finance_type || type == .caselsit_type{
            //收款
            if indexPath.row == 0 {
                //开始时间
                self.showTime_start()
            } else if indexPath.row == 1 {
                //结束时间
                self.showTime_end()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if type == .expense_type {
            return CGFloat(50)
        } else {
            return CGFloat(50)
        }
        
    }
    
    
    
    /// 显示时间
    func showTime_end() {
        timeView.removeFromSuperview()
        self.view.addSubview(timeView)
        timeView.delegate = self
        timeView.setData(type: 1)
        timeView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }
    func showTime_start() {
        timeView.removeFromSuperview()
        self.view.addSubview(timeView)
        timeView.delegate = self
        timeView.setData(type: 0)
        timeView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(160)
        }
    }

    func datePickViewTime(timeStr: String,type : Int) {
        if type == 0 {
            startTimeStr = timeStr
            startTimeCell.setTime(str: startTimeStr)
        } else {
            endTimeStr = timeStr
            endTimeCell.setTime(str: endTimeStr)
        }
    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        if self.type == .expense_type || self.type == .invoice_getlist {
            self.sureStateBlock(stateCell.cuurectID)
        } else if self.type == .work_type  {
            if titleCell.textField.isFirstResponder {
                titleCell.textField.resignFirstResponder()
            }
            if persionCell.textField.isFirstResponder {
                persionCell.textField.resignFirstResponder()
            }
            self.sureWorkBlock(titleCell.conTent,persionCell.contentStr,startTimeStr,endTimeStr)
        } else if self.type == .finance_type{
            if titleCell.textField.isFirstResponder {
                titleCell.textField.resignFirstResponder()
            }
            if persionCell.textField.isFirstResponder {
                persionCell.textField.resignFirstResponder()
            }
            self.sureFinanceBlock(titleCell.conTent,persionCell.contentStr,stateCell.cuurectID,startTimeStr,endTimeStr)
            
        } else if self.type == .caselsit_type {
            self.sureCaselsitBlock(startTimeStr,endTimeStr)
        }
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
