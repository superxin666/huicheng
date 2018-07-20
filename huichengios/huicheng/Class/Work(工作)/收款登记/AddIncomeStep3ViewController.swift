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
        mainTabelView.register(UINib.init(nibName: "DocTableViewCell", bundle: nil), forCellReuseIdentifier: DocTableViewCellID)

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
        let cell : DocTableViewCell  = tableView.dequeueReusableCell(withIdentifier: DocTableViewCellID, for: indexPath) as! DocTableViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DocTableViewCellH
    }
    // MARK: - net
    func requestApi() {
        requestVC.delegate = self
        requestVC.income_getdealsinfoRequest(id: idStr)

    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {

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
