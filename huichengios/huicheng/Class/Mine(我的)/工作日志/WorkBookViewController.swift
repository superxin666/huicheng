//
//  WorkBookViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//  工作日志

import UIKit


class WorkBookViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate ,MineRequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    
    let request : MineRequestVC = MineRequestVC()
    var dataArr :[work_getlistModel] = []
    
    var pageNum : Int = 1

    var bStr = ""
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
        self.navigation_title_fontsize(name: "工作日志", fontsize: 18)
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
            cell.setData(model: dataArr[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.dataArr.count {
            let model = self.dataArr[indexPath.row]

            let vc = AddWorkViewController()
            vc.type = .detail
            vc.workID = model.id
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return workbookcellHeight
    }
    
    func requestSucceed_mine(data: Any,type : MineRequestVC_enum) {
        let arr = data as! [work_getlistModel]
        if arr.count > 0 {
            dataArr = dataArr + arr
            HCLog(message: dataArr.count)
            mainTabelView.reloadData()
        } else {
            if pageNum > 1 {
               SVPMessageShow.showErro(infoStr: "已经加载全部内容")
            }
            
        }
        
        if mainTabelView.mj_footer.isRefreshing {
            mainTabelView.mj_footer.endRefreshing()
        }
    }
    func requestFail_mine() {
        
    }
    // MARK: - data
    @objc func loadMoreData() {
        HCLog(message: "加载更多")
        pageNum = pageNum + 1
        self.requestApi()
    }

    func reflish() {
        HCLog(message: "刷新")
        self.dataArr.removeAll()
        pageNum = 1
        self.requestApi()
    }
    
    func requestApi() {
        request.delegate = self
        request.work_getlistRequest(p: pageNum, c: 8)
    }
    // MARK: - event response
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func searchClick() {

        HCLog(message: "搜索")
        let vc = SearchViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.type = .workbook_type
        weak var weakself = self
        vc.sureCaselsitBlock = {(bid,b,e) in
            HCLog(message: b)
            HCLog(message: e)
//            weakself?.requestApi()
        }
        self.navigationController?.pushViewController(vc, animated: true)
        

    }
    @objc func addClick() {
        HCLog(message: "添加")
        let vc = AddWorkViewController()
        vc.type = .add
        weak var weakself = self
        vc.sucessBlock = {
            weakself?.reflish()
        }
        vc.hidesBottomBarWhenPushed = true
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
