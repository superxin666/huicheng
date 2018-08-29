


//
//  IncomeListViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/7/6.
//  Copyright © 2018年 lvxin. All rights reserved.
//  收款登记页面


import UIKit

class IncomeListViewController: BaseViewController ,UITableViewDataSource,UITableViewDelegate,Work2RequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = Work2RequestVC()
    var dataArr : [Income_getlistModel] = []
    var pageNum : Int = 1

    /// 合同编号
    var numStr = ""

    /// 查询时间段开始;
    var bStr = ""

    /// 查询时间段结束
    var eStr = ""

    /// u:交款人
    var uStr = ""

    /// 分所 ID，INT 型，可不传;
    var bidStr = ""

    /// 状态，INT 型;0-未审核;1-已审核;2-已驳回;3-已支付;
    var sStr = ""

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

        self.navigation_title_fontsize(name: "收款登记", fontsize: 18)
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
        mainTabelView.register(UINib.init(nibName: "DocTableViewCell", bundle: nil), forCellReuseIdentifier: DocTableViewCellID)
        mainTabelView.mj_footer = self.creactFoot()
        mainTabelView.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreData))
        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DocTableViewCell  = tableView.dequeueReusableCell(withIdentifier: DocTableViewCellID, for: indexPath) as! DocTableViewCell
        if indexPath.row < self.dataArr.count {
            let model : Income_getlistModel = self.dataArr[indexPath.row]
            cell.setData_incomeList(model: model)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row  < self.dataArr.count {
            let model : Income_getlistModel = self.dataArr[indexPath.row]
            let vc = IncomeDetailViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.id = "\(model.id!)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DocTableViewCellH
    }
    // MARK: - net
    func requestApi() {
        requestVC.delegate = self
        requestVC.income_getlistReuest(p: pageNum, c: 8, bid: 1, n: numStr,  b: bStr, e: eStr, u: uStr,s:sStr)
    }

    func reflishData() {
        if self.dataArr.count > 0 {
            self.dataArr.removeAll()
        }
        pageNum = 1
        self.requestApi()
    }
    @objc func loadMoreData() {
        HCLog(message: "加载更多")
        pageNum = pageNum + 1
        self.requestApi()
    }

    func requestSucceed_work2(data: Any, type: Work2RequestVC_enum) {
        let arr : [Income_getlistModel] = data as! [Income_getlistModel]
        if arr.count > 0 {
            self.dataArr = self.dataArr + arr
        }  else {
            if pageNum > 1 {
                SVPMessageShow.showErro(infoStr: "暂无数据")
            } else {

            }
        }
        self.mainTabelView.reloadData()
        if mainTabelView.mj_footer.isRefreshing {
            mainTabelView.mj_footer.endRefreshing()
        }

    }
    func requestFail_work2() {


    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func searchClick() {
        HCLog(message: "搜索")
        let vc = SearchViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.type = .Income_list
        weak var weakSelf = self
        vc.sureFinanceBlock = {(no,n,s,st,et) in
            weakSelf?.numStr = no
            weakSelf?.uStr = n
            weakSelf?.sStr = s
            weakSelf?.bStr = st
            weakSelf?.eStr = et
            weakSelf?.reflishData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }


    @objc func addClick() {
        HCLog(message: "添加")
        let vc = AddIconComeStep1ViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
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
