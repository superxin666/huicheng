//
//  IncomeViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//  我的收款

import UIKit
let IncomeTableViewCellid = "IncomeTableViewCell_id"
let IncomeTableViewCellH = CGFloat(80)
class IncomeViewController:  BaseViewController,UITableViewDataSource,UITableViewDelegate ,MineRequestVCDelegate {
    let mainTabelView : UITableView = UITableView()
    
    let request : MineRequestVC = MineRequestVC()
    var dataArr :[finance_getlistModel] = []
    
    
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
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "mes_logo"))
        self.navigation_title_fontsize(name: "我的收款", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        let iteam1 = self.getUIBarButtonItem(image: #imageLiteral(resourceName: "mine_search"), action: #selector(searchClick), vc: self)
        let iteam2 = self.getUIBarButtonItem(image:#imageLiteral(resourceName: "mine_add"), action: #selector(addClick), vc: self)
        self.navigationItem.rightBarButtonItems = [iteam1,iteam2]
        self.creatUI()
        request.delegate = self
        request.finance_getlistRequest()
        
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
        mainTabelView.register(UINib.init(nibName: "IncomeTableViewCell", bundle: nil), forCellReuseIdentifier: IncomeTableViewCellid)
        
        //        footer.setRefreshingTarget(self, refreshingAction: #selector(HomeViewController.loadMoreData))
        //        header.setRefreshingTarget(self, refreshingAction: #selector(HomeViewController.freshData))
        //        mainTabelView.mj_footer = footer
        //        mainTabelView.mj_header = header
        //        mainTabelView.register(MessageTableViewCell.self, forCellReuseIdentifier: MESSAGEID)
        //        mainTabelView.register(TeachTableViewCell.self, forCellReuseIdentifier: TEACHCELLID)
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
        let cell : IncomeTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: IncomeTableViewCellid, for: indexPath) as! IncomeTableViewCell
        if indexPath.row < dataArr.count {
            cell.setData(model: dataArr[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IncomeTableViewCellH
    }
    
    func requestSucceed(data: Any) {
        dataArr = data as! [finance_getlistModel]
        mainTabelView.reloadData()
    }
    func requestFail() {
        
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
