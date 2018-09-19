//
//  StatisticsViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/9/17.
//  Copyright © 2018年 lvxin. All rights reserved.
//  统计报表

import UIKit

class StatisticsViewController:  BaseViewController,UITableViewDataSource,UITableViewDelegate,Work2RequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = Work2RequestVC()
    var dataArr : [income_getcountModel] = []
    var pageNum : Int = 1

    /// 查询状态
    var sStr = "0"
    /// 分所 ID
    var bStr = ""
    /// 申请人
    var uStr = ""


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

        self.navigation_title_fontsize(name: "统计报表", fontsize: 18)
        self.navigationBar_rightBtn_image(image: #imageLiteral(resourceName: "mine_search"))
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
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
        mainTabelView.register(UINib.init(nibName: "StatisticsTableViewCell", bundle: nil), forCellReuseIdentifier: StatisticsTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "Statistics2TableViewCell", bundle: nil), forCellReuseIdentifier: Statistics2TableViewCellID)

//        mainTabelView.mj_footer = self.creactFoot()
//        mainTabelView.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreData))
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
        if dataArr.count > 0 {
            let model = dataArr[indexPath.row]
            if model.id > 0 {
                let cell : StatisticsTableViewCell  = tableView.dequeueReusableCell(withIdentifier: StatisticsTableViewCellID, for: indexPath) as! StatisticsTableViewCell
                cell.setData(model: model)
                return cell

            } else {
                let cell : Statistics2TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Statistics2TableViewCellID, for: indexPath) as! Statistics2TableViewCell
                cell.setData(model: model)
                return cell
            }
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataArr.count > 0 {
            let model = dataArr[indexPath.row]
            if model.id > 0 {
                return StatisticsTableViewCellH
            } else {
                return Statistics2TableViewCellH
            }
        } else {
            return 0
        }

    }
    // MARK: - net
    func requestApi() {
        requestVC.delegate = self
        requestVC.income_getcountRequest(p: pageNum, c: 8, n: "", b: "", e: "", u: "", bid: "", s: "", d: "")

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
        let arr : [income_getcountModel] = data as! [income_getcountModel]
        if arr.count > 0 {
            self.dataArr = self.dataArr + arr
        }  else {
            if pageNum > 1 {
                SVPMessageShow.showErro(infoStr: "暂无数据")
            } else {

            }
        }
        self.mainTabelView.reloadData()
//        if mainTabelView.mj_footer.isRefreshing {
//            mainTabelView.mj_footer.endRefreshing()
//        }

    }

    func requestFail_work2() {

    }

    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "搜索")
        let vc = SearchViewController()
        vc.type = .Expenseapply
        weak var weakself = self
        vc.expenBlock = {(st1,st2,st3) in
            weakself?.sStr = st1
            weakself?.bStr = st2
            weakself?.uStr = st3

            weakself?.reflishData()
        }
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
