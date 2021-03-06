//
//  MemoViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//  备忘录

import UIKit
let MemoTableViewCellID = "MemoTableViewCell_id"

class MemoViewController:  BaseViewController,UITableViewDataSource,UITableViewDelegate ,MineRequestVCDelegate {
    
    
    
    let mainTabelView : UITableView = UITableView()
    let request : MineRequestVC = MineRequestVC()
    var dataArr :[memo_getlistModel] = []
    var pageNum : Int = 1
    
    // MARK: - life
    override func viewWillLayoutSubviews() {
        mainTabelView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.requestApi()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = viewBackColor
        self.navigation_title_fontsize(name: "备忘录", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_image(image: #imageLiteral(resourceName: "mine_add"))
        self.creatUI()
        
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
        mainTabelView.register(UINib.init(nibName: "MemoTableViewCell", bundle: nil), forCellReuseIdentifier: MemoTableViewCellID)
        
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
        let cell : MemoTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCellID, for: indexPath) as! MemoTableViewCell
        if indexPath.row < dataArr.count {
            cell.setData(model: dataArr[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.dataArr.count {
            let model : memo_getlistModel = self.dataArr[indexPath.row]
            let vc = AddMemoViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.momeoID =  model.id
            vc.type = .detail_type
            vc.delSucessBlock = {
                self.reflishData()
            }
            vc.addSucessBlock = {
                self.reflishData()
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IncomeTableViewCellH
    }
    
    func requestSucceed_mine(data: Any,type : MineRequestVC_enum) {
    
        let arr = data as! [memo_getlistModel]
        if arr.count > 0 {
            if pageNum > 1 {
                dataArr = dataArr + arr
            } else {
                if dataArr.count > 0 {
                    self.dataArr.removeAll()
                }
                dataArr =  arr
            }
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

    func reflishData() {
        pageNum = 0
        if self.dataArr.count > 0 {
            self.dataArr.removeAll()
        }
        self.requestApi()
    }
    
    func requestApi() {
        request.delegate = self
        request.memo_getlistRequest(p: pageNum)
    }
    // MARK: - event response
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    override func navigationRightBtnClick() {
        HCLog(message: "添加")
        let vc = AddMemoViewController()
        vc.type = .add_type
        vc.hidesBottomBarWhenPushed = true
        vc.addSucessBlock = {
            self.reflishData()
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
