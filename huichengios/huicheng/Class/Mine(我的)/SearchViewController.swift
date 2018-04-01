//
//  SearchViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/30.
//  Copyright © 2018年 lvxin. All rights reserved.
//  搜索

import UIKit
typealias SearchViewControllerBlock = (_ stateId : String)->()
enum SearchViewController_type {
    //发票申请           收款记录
    case expense_type, finance_type
}
let Searchcell_expenseID = "Searchcell_expense_id"
let Searchcell_finance_typeID = "Searchcell_finance_type_id"
class SearchViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    /// 列表
    let mainTabelView : UITableView = UITableView()
//    类型
    var type : SearchViewController_type!
//   行数
    var rowNum : Int!
    
    /// 选择类型 block
    var sureStateBlock : SearchViewControllerBlock!
    
    var stateCell : SearchStateTableViewCell!
    
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
        if type == .expense_type {
            mainTabelView.register(UINib.init(nibName: "SearchStateTableViewCell", bundle: nil), forCellReuseIdentifier: Searchcell_expenseID)
        } else if type == .finance_type {
            mainTabelView.register(UINib.init(nibName: "SearchPersionTableViewCell", bundle: nil), forCellReuseIdentifier: Searchcell_finance_typeID)
            
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
            stateCell  = tableView.dequeueReusableCell(withIdentifier: Searchcell_expenseID, for: indexPath) as! SearchStateTableViewCell
            stateCell.type = .searchState
            stateCell.setData_searchState(titleStr: "状态")
            return stateCell
        } else if type == .finance_type{
            let cell : SearchPersionTableViewCell = tableView.dequeueReusableCell(withIdentifier: Searchcell_finance_typeID, for: indexPath) as! SearchPersionTableViewCell
            if indexPath.row == 0 {
                //交款人
                cell.setData(titleStr: "交款人", fieldTag: 0)
            } else if indexPath.row == 1 {
                //合同编号
                cell.setData(titleStr: "合同编号", fieldTag: 1)
            } else if indexPath.row == 2 {
                //开始时间
                
            } else if indexPath.row == 3 {
                //结束时间
                
            } else {
                //状态
                stateCell  = tableView.dequeueReusableCell(withIdentifier: Searchcell_expenseID, for: indexPath) as! SearchStateTableViewCell
                return stateCell
            }
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if type == .expense_type {
            return CGFloat(50)
        } else {
            return 0
        }
        
    }
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        self.sureStateBlock(stateCell.cuurectID)
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
