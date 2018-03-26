//
//  invoiceViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//  发票申请

import UIKit
let  InvoiceTableViewCellID = "InvoiceTableViewCell_id"
let InvoiceViewTableViewCellH = CGFloat(105)


class InvoiceViewController:  BaseViewController, UITableViewDataSource, UITableViewDelegate , MineRequestVCDelegate {
    
    /// 列表
    let mainTabelView : UITableView = UITableView()
    
    
    let request : MineRequestVC = MineRequestVC()
    var dataArr :[invoice_getlistModel] = []
    
    var pageNum : Int = 1
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
        
        self.navigation_title_fontsize(name: "发票申请", fontsize: 18)
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
        mainTabelView.register(UINib.init(nibName: "InvoiceTableViewCell", bundle: nil), forCellReuseIdentifier: InvoiceTableViewCellID)
        mainTabelView.mj_footer = self.creactFoot()
        mainTabelView.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreData))
        mainTabelView.mj_header = header
        header.setRefreshingTarget(self, refreshingAction: #selector(reflishData))
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
        let cell : InvoiceTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: InvoiceTableViewCellID, for: indexPath) as! InvoiceTableViewCell
        if indexPath.row < dataArr.count {
            cell.setData(model: dataArr[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return InvoiceViewTableViewCellH
    }
    
    func requestSucceed(data: Any) {
        let arr = data as! [invoice_getlistModel]
        if arr.count > 0 {
            dataArr = dataArr + arr
            HCLog(message: dataArr.count)
            mainTabelView.reloadData()
        } else {
            SVPMessageShow.showErro(infoStr: "已经加载全部内容")
        }
        if mainTabelView.mj_footer.isRefreshing {
            mainTabelView.mj_footer.endRefreshing()
        }
        if mainTabelView.mj_header.isRefreshing {
            mainTabelView.mj_header.endRefreshing()
        }
    }
    func requestFail() {
        
    }
    // MARK: - data
    @objc func loadMoreData() {
        HCLog(message: "加载更多")
        pageNum = pageNum + 1
        self.requestApi()
    }
    @objc func reflishData() {
        HCLog(message: "刷新")
        self.dataArr.removeAll()
        pageNum = 1
        self.requestApi()
    }
    
    
    func requestApi() {
        request.delegate = self
        request.invoice_getlistRequest(p: pageNum, c: 8)
    }
    
    // MARK: - event response
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func searchClick() {
        HCLog(message: "搜索")
    }
    @objc func addClick() {
        HCLog(message: "添加")
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
