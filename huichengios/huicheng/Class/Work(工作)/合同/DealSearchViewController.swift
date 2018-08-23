//
//  DealSearchViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/5/10.
//  Copyright © 2018年 lvxin. All rights reserved.
//  合同查询

import UIKit

class DealSearchViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,WorkRequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = WorkRequestVC()
    var dataArr : [dealGetlistModel] = []
    var pageNum : Int = 0

    var numStr = ""
    var dStr = ""
    var bStr = ""
    var eStr = ""
    var kwStr = ""
    var uStr = ""
    var tStr = ""
    var wuStr = ""
    var icStr = ""
    var ioStr = ""


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

        self.navigation_title_fontsize(name: "合同查询", fontsize: 18)
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
            cell.setData_deal(model: self.dataArr[indexPath.row])

        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row  < self.dataArr.count {
            let model :dealGetlistModel  = self.dataArr[indexPath.row]

            let vc = DealDetailViewController()
            vc.dealID = model.id
            vc.type = .searchDeal
            weak var weakself = self
            vc.sucessBlock = {
                weakself?.reflishData()
            }
            self.navigationController?.pushViewController(vc, animated: true)

        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CaseTableViewCellH
    }
    // MARK: - net
    func requestApi() {
        requestVC.delegate = self
        requestVC.searchlistReuest(p: pageNum, c: 8, n: numStr, d: dStr, b: bStr, e: eStr, kw: kwStr, u: uStr, t: tStr, wu: wuStr, ic: icStr, io: ioStr)
    }

    func reflishData() {
        if self.dataArr.count > 0 {
            self.dataArr.removeAll()
        }
        pageNum = 0
        self.requestApi()
    }
    @objc func loadMoreData() {
        HCLog(message: "加载更多")
        pageNum = pageNum + 1
        self.requestApi()
    }
    func requestSucceed_work(data: Any,type : WorkRequestVC_enum) {
        let arr : [dealGetlistModel] = data as! [dealGetlistModel]
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
        let vc = DealSearch2ViewController()
        weak var weakself = self
        vc.sucessBlock = {(numStr,dStr,bStr,eStr,kwStr,uStr,tStr,wuStr,icStr,ioStr) in
            HCLog(message: numStr)
            
            self.numStr = numStr
            self.dStr = dStr
            self.bStr = bStr
            self.eStr = eStr
            self.kwStr = kwStr
            self.uStr = uStr
            self.tStr = tStr
            self.wuStr = wuStr
            self.icStr = icStr
            self.ioStr = ioStr

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
