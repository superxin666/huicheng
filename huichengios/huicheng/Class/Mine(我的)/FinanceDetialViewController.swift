//
//  FinanceDetialViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/30.
//  Copyright © 2018年 lvxin. All rights reserved.
//  收入详情

import UIKit
let FinanceDetialViewControllerCellH = CGFloat(50)
let FinanceDetialTableViewCellID = "FinanceDetialTableViewCell_id"
class FinanceDetialViewController: BaseViewController,MineRequestVCDelegate,UITableViewDelegate,UITableViewDataSource {
    
    let mainTabelView : UITableView = UITableView()
    let request : MineRequestVC = MineRequestVC()
    var dataModel : finance_getinfoModel!
    let titleArr = ["合同信息","报销信息","支付信息",]
    let name1 = ["合同编号","委托人","合同金额","已付金额"]
    let content1 = ["合同编号","委托人","合同金额","已付金额"]
    let name2 = ["类型","发票金额","审核人","审核时间"]
    let content2 = ["合同编号","委托人","合同金额","已付金额"]
    let name3 = ["收款律师","金额","支行信息","卡号","状态","经办人","支付时间"]
    let content3 = ["收款律师","金额","支行信息","卡号","状态","经办人","支付时间"]

    var financeId : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigation_title_fontsize(name: "我的收款", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.creatUI()
//        request.delegate = self
//        request.finance_getinfoRequest(id: financeId)

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
        mainTabelView.register(UINib.init(nibName: "FinanceDetialTableViewCell", bundle: nil), forCellReuseIdentifier: FinanceDetialTableViewCellID)
        self.view.addSubview(mainTabelView)
    }
    
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 4
        } else if section == 1 {
            return 4
        } else {
            return 7
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FinanceDetialTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: FinanceDetialTableViewCellID, for: indexPath) as! FinanceDetialTableViewCell
        if indexPath.section == 0 {
            cell.setData(title: name1[indexPath.row], content: content1[indexPath.row])
        } else if indexPath.section == 1 {
            cell.setData(title: name2[indexPath.row], content: content2[indexPath.row])
        } else {
            cell.setData(title: name3[indexPath.row], content: content3[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FinanceDetialViewControllerCellH
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = FinanceDetialHeadView()
        view.setData(name: titleArr[section])
        return view
        
    }
    func requestSucceed(data: Any,type : MineRequestVC_enum) {
        let model : finance_getinfoModel = data as! finance_getinfoModel
        
        
    }
    func requestFail() {
        
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
