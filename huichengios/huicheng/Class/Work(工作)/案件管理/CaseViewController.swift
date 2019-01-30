//
//  CaseViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/12.
//  Copyright © 2018年 lvxin. All rights reserved.
//  案件管理

import UIKit

class CaseViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,WorkRequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = WorkRequestVC()
    var dataArr : [checkcaseModel] = []
    var pageNum : Int = 1

    /// 开始时间
    var bTimeStr = ""

    /// 结束时间
    var endTimeStr = ""

    var bidStr = ""



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

        self.navigation_title_fontsize(name: "案件管理", fontsize: 18)
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
        mainTabelView.register(UINib.init(nibName: "CaseTableViewCell", bundle: nil), forCellReuseIdentifier: CaseTableViewCellId)
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
        let cell : CaseTableViewCell  = tableView.dequeueReusableCell(withIdentifier: CaseTableViewCellId, for: indexPath) as! CaseTableViewCell
        if indexPath.row < self.dataArr.count {
            cell.setData(model: self.dataArr[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row  < self.dataArr.count {
            let model : checkcaseModel  = self.dataArr[indexPath.row]
            let vc = CaseDetailViewController()
            vc.caseId = model.id
            vc.type = .caseDetail
            weak var weakself = self
            vc.successBlock = {
                weakself?.reflishData()
            }
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CaseTableViewCellH
    }
    // MARK: - net
    func requestApi() {
        requestVC.delegate = self
        requestVC.casegetlistRerquest(bid : bidStr,p: pageNum, c: 8, b: bTimeStr, s: endTimeStr)

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
    func requestSucceed_work(data: Any,type : WorkRequestVC_enum) {
        let arr : [checkcaseModel] = data as! [checkcaseModel]
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

    func requestFail_work() {

    }


    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "搜索")
        let vc = SearchViewController()
        vc.type = .caselsit_type
        vc.typeSub = 0
        weak var weakself = self
        vc.sureCaselsitBlock = {( bid,startTime ,endTime) in
            HCLog(message: startTime)
            HCLog(message: endTime)
            HCLog(message: bid)

            weakself?.bTimeStr = startTime
            weakself?.endTimeStr = endTime
            weakself?.bidStr = bid
            weakself?.reflishData()

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
