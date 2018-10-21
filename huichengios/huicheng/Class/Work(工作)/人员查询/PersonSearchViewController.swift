//
//  PersonSearchViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/10/18.
//  Copyright © 2018年 lvxin. All rights reserved.
//  人员查询

import UIKit

class PersonSearchViewController:  BaseViewController ,UITableViewDataSource,UITableViewDelegate,Work2RequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = Work2RequestVC()
    var dataArr : [usermanageModel] = []
    var pageNum : Int = 1

    /// 合同编号
    var nStr = ""
    /// 收款人，纯文本模糊查询
    var uStr = ""
    /// 分所id
    var bidStr = ""
    /// 收款日期起始
    var bStr = ""
    /// 收款日期结束
    var eStr = ""



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

        self.navigation_title_fontsize(name: "人员查询", fontsize: 18)
//        self.navigationBar_rightBtn_image(image: #imageLiteral(resourceName: "mine_search"))
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
            let model : usermanageModel = self.dataArr[indexPath.row]
            cell.setDta_usermanage(model: model)

        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row  < self.dataArr.count {
            let model : usermanageModel = self.dataArr[indexPath.row]
            let vc : PersonInfoViewController = PersonInfoViewController()
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
        requestVC.usermanageReuqet(p: pageNum, c: 8, bid: "", u: "", n: "", d: "", ca: "", dp: "", s: "", bd: "", ed: "")
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
    func requestSucceed_work2(data: Any,type : Work2RequestVC_enum) {
        if type == .usermanage {
            let arr : [usermanageModel] = data as! [usermanageModel]
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

    }



    func requestFail_work2() {

    }


    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "搜索")

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
