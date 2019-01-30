//
//  CrtDealslistViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/8.
//  Copyright © 2018年 lvxin. All rights reserved.
//  诉讼函

import UIKit
enum CrtDealslistViewControllerType {
    case type1;//诉讼
    case type2;//非诉讼
    case type3//行事案件
    case type4;//法律顾问
}

class CrtDealslistViewController:   BaseViewController,UITableViewDataSource,UITableViewDelegate,Work2RequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = Work2RequestVC()
    var dataArr : [CrtDealslistModel] = []
    var pageNum : Int = 1
    var tNum : Int = 1
    /// 合同编号
    var numStr = ""
    var bidStr = ""

    var viewType : CrtDealslistViewControllerType = .type1



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


        switch viewType {
        case .type1:
            self.navigation_title_fontsize(name: "诉讼案件", fontsize: 18)
            tNum = 1
        case .type2:
            self.navigation_title_fontsize(name: "非诉案件", fontsize: 18)
            tNum = 2
        case .type3:
            self.navigation_title_fontsize(name: "刑事案件", fontsize: 18)
            tNum = 3
        case .type4:
            self.navigation_title_fontsize(name: "法律顾问", fontsize: 18)
            tNum = 4
        default:
            self.navigation_title_fontsize(name: "诉讼案件", fontsize: 18)
        }
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
            cell.setData_crt(model: self.dataArr[indexPath.row])

        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row  < self.dataArr.count {
            let model :CrtDealslistModel  = self.dataArr[indexPath.row]
            let vc = CaseDetailViewController()
            vc.caseId = model.id
            vc.type = .crtDetail
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
        requestVC.crt_dealslistRequest(bid : bidStr,p: pageNum, c: 8, n: numStr, t: tNum)
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
        let arr : [CrtDealslistModel] = data as! [CrtDealslistModel]
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
    override func navigationRightBtnClick() {
        HCLog(message: "搜索")
        let vc = SearchViewController()
        vc.type = .deal_type

        switch viewType {
        case .type1:
            vc.typeSub = 5
        case .type2:
            vc.typeSub = 6
        case .type3:
            vc.typeSub = 7
        case .type4:
            vc.typeSub = 8
        default:
            vc.typeSub = 5
        }

        weak var weakself = self
        vc.sureDealBlock = {(bid,content) in
            weakself?.numStr = content
            weakself?.bidStr = bid
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
