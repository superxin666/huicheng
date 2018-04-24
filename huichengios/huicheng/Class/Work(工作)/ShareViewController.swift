//
//  ShareViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/23.
//  Copyright © 2018年 lvxin. All rights reserved.
//  共享魔板

import UIKit

class ShareViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,WorkRequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    let requestVC = WorkRequestVC()
    var dataArr : [shareGetlistModel] = []
    var pageNum : Int = 1

    var headView : ShareHeadView!

    /// 合同编号
    var numStr = ""

    var alertController : UIAlertController!
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
        self.navigationBar_rightBtn_image(image: #imageLiteral(resourceName: "mine_search"))
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.creatUI()
        self.requestApi()
    }
    // MARK: - UI
    func creatUI() {

        headView = ShareHeadView.loadNib()

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
        let cell : RoomTableViewCell  = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCellID, for: indexPath) as! RoomTableViewCell
        if indexPath.row < self.dataArr.count {
            let model = self.dataArr[indexPath.row]
            cell.setData_share(model: model)
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
        if indexPath.row  < self.dataArr.count {


        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RoomTableViewCellH
    }
    // MARK: - net
    func requestApi() {
        requestVC.delegate = self
        requestVC.sharegetlistRequest(p: pageNum, c: 8, t: "", kw: "")
    }

    func reflishData() {
        if self.dataArr.count > 0 {
            self.dataArr.removeAll()
        }
        pageNum = 1
        self.requestApi()
    }


    func requestSucceed_work(data: Any,type : WorkRequestVC_enum) {
        self.dataArr = data as! [shareGetlistModel]

    }

    func requestFail_work() {

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
