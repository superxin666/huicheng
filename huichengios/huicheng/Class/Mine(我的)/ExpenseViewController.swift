//
//  SubmitPayViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//  报销申请

import UIKit
let SUBMITPAYID = "SUBMITPAY_ID"
let subPay_cell_height = CGFloat(80)

class ExpenseViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate ,MineRequestVCDelegate{
    /// 列表
    let mainTabelView : UITableView = UITableView()
    let request : MineRequestVC = MineRequestVC()
    var dataArr :[expense_getlistModel] = []
    
    var pageNum : Int = 1
    
    /// 查询状态:可为空 0-未审核;1-已审核;2-审核驳回;3-已支付
    var state : String!
    
    // MARK: - life
    override func viewWillLayoutSubviews() {
        mainTabelView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor

        self.navigation_title_fontsize(name: "报销申请", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        let iteam1 = self.getUIBarButtonItem(image: #imageLiteral(resourceName: "mine_search"), action: #selector(searchClick), vc: self)
        let iteam2 = self.getUIBarButtonItem(image:#imageLiteral(resourceName: "mine_add"), action: #selector(addClick), vc: self)
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
        mainTabelView.register(UINib.init(nibName: "SubPayTableViewCell", bundle: nil), forCellReuseIdentifier: SUBMITPAYID)
        mainTabelView.mj_footer = self.creactFoot()
        mainTabelView.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreData))
        mainTabelView.mj_header = header
        header.setRefreshingTarget(self, refreshingAction: #selector(reflishData))
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
        let cell : SubPayTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: SUBMITPAYID, for: indexPath) as! SubPayTableViewCell
        if indexPath.row < dataArr.count {
            cell.setData(model: dataArr[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.dataArr.count {
            let model = self.dataArr[indexPath.row]
            let vc = AddExpenseViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.type = .detaile_type
            vc.expenseId = model.id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return subPay_cell_height
    }
    
    func requestSucceed(data: Any,type : MineRequestVC_enum) {
        let arr = data as! [expense_getlistModel]
        if arr.count > 0 {
            
            if pageNum > 1 {
                dataArr = dataArr + arr
            } else {
                if dataArr.count > 0 {
                    self.dataArr.removeAll()
                }
                dataArr =  arr
            }
            HCLog(message: dataArr.count)
      
        } else {
            if pageNum > 1 {
                      SVPMessageShow.showErro(infoStr: "已经加载全部内容")
            } else {
                
            }
        }
        mainTabelView.reloadData()
        if mainTabelView.mj_footer.isRefreshing {
            mainTabelView.mj_footer.endRefreshing()
        }
        if mainTabelView.mj_header.isRefreshing {
            mainTabelView.mj_header.endRefreshing()
        }
    }
    func requestFail() {
        
    }
    // MARK: - data
    @objc func loadMoreData() {
        HCLog(message: "加载更多")
        pageNum = pageNum + 1
        self.requestApi()
    }
    @objc func reflishData() {
        HCLog(message: "刷新")
        self.dataArr.removeAll()
        pageNum = 1
        self.requestApi()
    }
    
    
    func requestApi() {
        request.delegate = self
        if let stateNum = state {
            request.expense_getlistRequest(p: pageNum, c: 8, s: stateNum)
        } else {
            request.expense_getlistRequest(p: pageNum, c: 8, s: "")
        }
    }

    // MARK: - event response
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func searchClick() {
        HCLog(message: "搜索")
        let vc = SearchViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.type = .expense_type
        weak var weakSelf = self
        vc.sureStateBlock = {(idstr) in
            weakSelf?.dataArr.removeAll()
            weakSelf?.state = idstr
            weakSelf?.requestApi()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func addClick() {
        HCLog(message: "添加")
        let vc = AddExpenseViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.type = .add_type
        weak var weakSelf = self
        vc.sureStateBlock = {
            weakSelf?.requestApi()
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
