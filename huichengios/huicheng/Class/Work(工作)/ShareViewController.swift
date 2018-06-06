//
//  ShareViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//  共享魔板

import UIKit

class ShareViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,WorkRequestVCDelegate,ShareHeadViewDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = WorkRequestVC()
    var dataArr : [shareGetlistModel] = []
    var dataArr_my : [shareGetlistModel] = []
    var pageNum : Int = 1
    var pageNum_my : Int = 1
    var headView : ShareHeadView!

    /// 合同编号
    var numStr = ""

    var alertController : UIAlertController!

    // 0-共享 1-我的
    var viewType = 0

    // MARK: - life
    override func viewWillLayoutSubviews() {
        headView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(LNAVIGATION_HEIGHT)
            make.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(self.view).offset(45)
        }

        mainTabelView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headView).offset(45)
            make.left.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor

        self.navigation_title_fontsize(name: "共享模板", fontsize: 18)
        let iteam1 = self.getUIBarButtonItem(image: #imageLiteral(resourceName: "mine_search"), action: #selector(searchClick), vc: self)
        let iteam2 = self.getUIBarButtonItem(image:#imageLiteral(resourceName: "mine_add"), action: #selector(addClick), vc: self)
        self.navigationItem.rightBarButtonItems = [iteam2,iteam1]
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        requestVC.delegate = self
        self.creatUI()
        self.requestApi()
    }
    // MARK: - UI
    func creatUI() {

        headView = ShareHeadView.loadNib()
        headView.delegate = self
        self.view.addSubview(headView)

        mainTabelView.backgroundColor = UIColor.clear
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.backgroundView?.backgroundColor = .clear
        mainTabelView.register(UINib.init(nibName: "RoomTableViewCell", bundle: nil), forCellReuseIdentifier: RoomTableViewCellID)
//        mainTabelView.mj_footer = self.creactFoot()
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreData))

        mainTabelView.mj_footer = footer
        mainTabelView.estimatedRowHeight = 0
        mainTabelView.estimatedSectionHeaderHeight = 0
        mainTabelView.estimatedSectionFooterHeight = 0
        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewType == 0  {
            return self.dataArr.count
        } else {
            return self.dataArr_my.count
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : RoomTableViewCell  = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCellID, for: indexPath) as! RoomTableViewCell
        if viewType == 0  {
            //共享
            if indexPath.row < self.dataArr.count {
                let model = self.dataArr[indexPath.row]
                cell.setData_share(model: model)
            }
        } else {
            //我的
            if indexPath.row < self.dataArr_my.count {
                let model = self.dataArr_my[indexPath.row]
                cell.setData_shareMy(model: model)
            }
        }
        weak var weakself = self

        cell.delBlock = {model in

            weakself?.alertController = UIAlertController(title: nil, message: "是否删除本条记录", preferredStyle: .alert)
            let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in
                HCLog(message: "确定")
                weakself?.requestVC.roomdel(id: model.id)
            }
            let cancleAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                self.alertController.dismiss(animated: true, completion: {

                })
            }
            weakself?.alertController.addAction(cancleAction)
            weakself?.alertController.addAction(sureAction)
            self.present((weakself?.alertController)!, animated: true, completion: nil)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HCLog(message: "点击")
        var model = shareGetlistModel()
        if self.viewType == 0 {
            if !(dataArr.count > 0) {
                return
            }
            model = self.dataArr[indexPath.row]
        } else {
            if !(dataArr_my.count > 0) {
                return
            }
            model = self.dataArr_my[indexPath.row]
        }

        let vc = ShareDetailViewController()
        vc.shareID = model.id
        self.navigationController?.pushViewController(vc, animated: true)

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RoomTableViewCellH
    }
    // MARK: - net
    func requestApi() {
        SVPMessageShow.showLoad(title: "正在加载~~")

        if viewType == 0 {
            requestVC.sharegetlistRequest(p: pageNum, c: 8, t: "", kw: "")
        } else {
            requestVC.sharegetmylistRequest(p: pageNum_my, c: 8, t: "", kw: "")
        }

    }

//    func reflishData() {
//        if viewType == 0 {
//            if self.dataArr.count > 0 {
//                self.dataArr.removeAll()
//            }
//            pageNum = 1
//        } else {
//            if self.dataArr_my.count > 0 {
//                self.dataArr_my.removeAll()
//            }
//            pageNum_my = 1
//        }
//        self.requestApi()
//    }

    @objc func loadMoreData() {
        if viewType == 0 {
            pageNum = pageNum + 1
        } else {
            pageNum_my = pageNum_my + 1
        }

        self.requestApi()
    }



    func requestSucceed_work(data: Any,type : WorkRequestVC_enum) {

        SVPMessageShow.dismissSVP()
        let arr = data as! [shareGetlistModel]
        if arr.count > 0 {
            if viewType == 0 {
                dataArr = dataArr + arr
            } else {
                dataArr_my = dataArr_my + arr
            }
            HCLog(message: dataArr.count)
            HCLog(message: dataArr_my.count)
            mainTabelView.reloadData()
        } else {
            if viewType == 0 {
                if pageNum > 1{
                    SVPMessageShow.showErro(infoStr: "已经加载全部内容")
//                       self.mainTabelView.mj_footer.resetNoMoreData()
                }
            } else {
                if pageNum_my > 1{
                    SVPMessageShow.showErro(infoStr: "已经加载全部内容")
//                       self.mainTabelView.mj_footer.resetNoMoreData()
                }
            }
        }
        if mainTabelView.mj_footer.isRefreshing {
            mainTabelView.mj_footer.endRefreshing()

        }


    }

    func requestFail_work() {

    }

    func headViewClick(tagNum: Int) {
        viewType = tagNum
        HCLog(message: "点击\(viewType)")
        HCLog(message: pageNum)
        HCLog(message: pageNum_my)
                self.mainTabelView.mj_footer.resetNoMoreData()
        if tagNum == 0  {
            //共享列表
            if dataArr.count > 0 {
                self.mainTabelView.reloadData()
            } else {
                HCLog(message: "请求公共列表")
                self.requestApi()
            }

        } else {
            //我的共享列表
            if dataArr_my.count > 0 {

                self.mainTabelView.reloadData()
            } else {
                HCLog(message: "请求我的公共列表")
                self.requestApi()
            }
        }
    }

    @objc func searchClick() {
        HCLog(message: "搜索")

    }
    @objc func addClick() {
        HCLog(message: "添加")
        let vc = AddShareViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
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
