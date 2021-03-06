//
//  ReleaseViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  公告

import UIKit

class NoticeViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,WorkRequestVCDelegate {

    let mainTabelView : UITableView = UITableView()
    
    let request : WorkRequestVC = WorkRequestVC()
    var dataArr :[newslist1Model] = []
    var pageNum : Int = 1
    var titleStr : String = ""
    var perStr : String = ""
    var startTime : String = ""
    var endTime : String = ""
    var subStr = ""

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
        
        self.navigation_title_fontsize(name: "发布公告", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        let iteam1 = self.getUIBarButtonItem(image: #imageLiteral(resourceName: "mine_search"), action: #selector(searchClick), vc: self)
        let iteam2 = self.getUIBarButtonItem(image:#imageLiteral(resourceName: "mine_add"), action: #selector(addClick), vc: self)
        self.navigationItem.rightBarButtonItems = [iteam1,iteam2]
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
        mainTabelView.register(UINib.init(nibName: "WorkBookTableViewCell", bundle: nil), forCellReuseIdentifier: workbookcellid)
        mainTabelView.mj_footer = self.creactFoot()
        mainTabelView.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreData))
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
        let cell : WorkBookTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: workbookcellid, for: indexPath) as! WorkBookTableViewCell
        if indexPath.row < dataArr.count {
            cell.setData_news(model: dataArr[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.dataArr.count {
            let model = self.dataArr[indexPath.row]
            let vc = AddNoticeViewController()
            vc.detailId = model.id
            vc.type = .detail
            weak var weakSelf = self
            vc.reflishBlock = {
               weakSelf?.reflishData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return workbookcellHeight
    }
    
    func requestSucceed_work(data: Any,type : WorkRequestVC_enum) {
        let arr : [newslist1Model] = data as! [newslist1Model]
        if arr.count > 0 {
            dataArr =  dataArr + arr
        } else {
            if pageNum > 1 {
                SVPMessageShow.showErro(infoStr: "已经加载所有数据")
            }
        }
        self.mainTabelView.reloadData()
        if mainTabelView.mj_footer.isRefreshing {
            mainTabelView.mj_footer.endRefreshing()
        }

    }
    func requestFail_work() {
        
    }
    func requestApi() {
        request.delegate = self
        request.newslist1Request(subid: subStr,p: pageNum, c: 8, bid: 0, t: self.titleStr, b: self.startTime, e: self.endTime, u: self.perStr)
        
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
    @objc func searchClick() {
        HCLog(message: "搜索")
        let vc = SearchViewController()
        vc.type = .work_type
        vc.typeSub = 18
        weak var weakself = self
        vc.sureWorkBlock = {(sub,titleStr, perStr, startTime ,endTime) in
            HCLog(message: titleStr)
            HCLog(message: perStr)
            HCLog(message: startTime)
            HCLog(message: endTime)
            weakself?.subStr = sub
            weakself?.titleStr = titleStr
            weakself?.perStr = perStr
            weakself?.startTime = startTime
            weakself?.endTime = endTime
            weakself?.reflishData()
            
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func addClick() {
        HCLog(message: "添加")
        let vc = AddNoticeViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.type = .addNotice
        weak var weakself = self
        vc.reflishBlock = {
            weakself?.reflishData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
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
