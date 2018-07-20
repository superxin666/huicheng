//
//  AddIncomeStep3ViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/7/20.
//  Copyright © 2018年 lvxin. All rights reserved.
//  合同详情

import UIKit

class AddIncomeStep3ViewController:BaseViewController ,UITableViewDataSource,UITableViewDelegate,Work2RequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = Work2RequestVC()
    var nameArr = ["合同编号","立案时间","立案律师","委托人","案件组别","合同金额","已付金额","收款历史"]
    var contenArr : [String] = ["","","","","","","","",]
    var dataModel : income_getdealsinfoModel!


    /// 合同 ID
    var idStr : Int!

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

        self.navigation_title_fontsize(name: "合同详情", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        let iteam1 = self.getUIBarButtonItem_title(title: "收款记录", action: #selector(searchClick), vc: self)
        let iteam2 = self.getUIBarButtonItem_title(title: "收款详情", action: #selector(addClick), vc: self)
        self.navigationItem.rightBarButtonItems = [iteam2,iteam1]
        self.creatUI()
        self.requestApi()
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
        mainTabelView.register(UINib.init(nibName: "Title2TableViewCell", bundle: nil), forCellReuseIdentifier: Title2TableViewCellID)
        mainTabelView.register(UINib.init(nibName: "Title4TableViewCell", bundle: nil), forCellReuseIdentifier: Title4TableViewCellID)
        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 7 {
            let cell : Title2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title2TableViewCellID, for: indexPath) as! Title2TableViewCell
            cell.setData(titleStr: nameArr[indexPath.row])
            return cell

        } else {
            let cell : Title4TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
            cell.setData_overCase(titleStr: nameArr[indexPath.row], contentStr: contenArr[indexPath.row])
            return cell
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 7 {
            return Title2TableViewCellH
        } else {
            return Title4TableViewCellH
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 7 {
            if self.dataModel.income.count > 0 {
                let vc = IncomeHistoryViewController()
                vc.hidesBottomBarWhenPushed = true
                vc.dataModelArr = dataModel.income
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                SVPMessageShow.showErro(infoStr: "暂无记录")
            }

        }
    }
    // MARK: - net
    func requestApi() {
        requestVC.delegate = self
        requestVC.income_getdealsinfoRequest(id: idStr)

    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {

        dataModel = data as! income_getdealsinfoModel
        if let str = dataModel.data.dealsnum{
//            contenArr.append(str)
            contenArr[0] = str
        }
        if let str = dataModel.data.regtime{
//            contenArr.append(str)
            contenArr[1] = str
        }
        if let str = dataModel.data.reguser{
//            contenArr.append(str)
            contenArr[2] = str
        }
        if let str = dataModel.data.principal{
//            contenArr.append(str)
            contenArr[3] = str
        }
        if let str = dataModel.data.branch{
//            contenArr.append(str)
            contenArr[4] = str
        }
        contenArr[5] = "接口没给数据"
        contenArr[6] = "接口没给数据"
        self.mainTabelView.reloadData()
    }

    func requestFail_work2() {


    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func searchClick() {
        HCLog(message: "收款记录")
    }


    @objc func addClick() {
        HCLog(message: "收款详情")
    }
}
