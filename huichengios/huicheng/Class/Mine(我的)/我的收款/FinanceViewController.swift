//
//  IncomeViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//  我的收款

import UIKit
let IncomeTableViewCellid = "SUBMITPAY_ID"
let IncomeTableViewCellH = CGFloat(80)
class FinanceViewController:  BaseViewController,UITableViewDataSource,UITableViewDelegate ,MineRequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    
    let request : MineRequestVC = MineRequestVC()
    var dataArr :[finance_getlistModel] = []
    
    var pageNum : Int = 1
    

    var nStr : String = ""
    var sStr : String = ""
    var startTime : String = ""
    var endTime : String = ""
    var noStr : String = ""
    
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
      
        self.navigation_title_fontsize(name: "我的收款", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_image(image: #imageLiteral(resourceName: "mine_search"))
        self.creatUI()
        request.delegate = self
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
        mainTabelView.register(UINib.init(nibName: "SubPayTableViewCell", bundle: nil), forCellReuseIdentifier: IncomeTableViewCellid)
    
        self.view.addSubview(mainTabelView)
    }
    
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SubPayTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: IncomeTableViewCellid, for: indexPath) as! SubPayTableViewCell
        if indexPath.row < dataArr.count {
            cell.setData_finance(model: dataArr[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.dataArr.count {
            let model  = self.dataArr[indexPath.row]
            let vc = FinanceDetialViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.financeId = model.id
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IncomeTableViewCellH
    }
    
    
    // MARK: - net
    func requestApi() {
         request.finance_getlistRequest(p: pageNum, c: 8, no: noStr, n: nStr, s: sStr, st: startTime, et: endTime)
    }
    
    func requestSucceed_mine(data: Any,type : MineRequestVC_enum) {
        dataArr = data as! [finance_getlistModel]
        mainTabelView.reloadData()
    }
    func requestFail_mine() {
        
    }
    
    // MARK: - event response
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "搜索")
        let vc = SearchViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.type = .finance_type
        weak var weakself = self
        vc.sureFinanceBlock = {(no,n,s,st,et) in
            weakself?.noStr = no
            weakself?.nStr = n
            weakself?.sStr = s
            weakself?.startTime = st
            weakself?.endTime = et
            weakself?.requestApi()
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
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
