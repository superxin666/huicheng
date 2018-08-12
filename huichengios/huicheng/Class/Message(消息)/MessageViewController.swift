//
//  MessageViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//  消息

import UIKit
let MESSAGEID = "MESSAGE_ID"
let message_cell_height = ip6(80)

class MessageViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,MessageRequestVCDelegate {
    
    let request = MessageRequestVC()
    var dataArr : [noticelistModel] = []
    
    var pageNum : Int = 1
    
    
    /// 列表
    let mainTabelView : UITableView = UITableView()
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
        self.navigationBar_rightBtn_image(image: #imageLiteral(resourceName: "mes_ alarm"))
        self.navigation_title_fontsize(name: "消息", fontsize: 18)
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
        mainTabelView.register(UINib.init(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: MESSAGEID)
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
        let cell : MessageTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: MESSAGEID, for: indexPath) as! MessageTableViewCell
        if indexPath.row < dataArr.count {
            cell.setData(model: dataArr[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < self.dataArr.count {
            let model = self.dataArr[indexPath.row]
            HCLog(message: model.strHeight!)
            return model.strHeight! + message_cell_height - ip6(10)

        } else {
            return message_cell_height

        }
    }
    func requestSucceed_message(data: Any) {
        let arr = data as! [noticelistModel]
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
    func requestFail_message() {
        
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
        request.noticelistRequest(p: pageNum, c: 8)
    }
    
    // MARK: - event response
    override func navigationRightBtnClick() {
        let vc = PubMessageViewController()
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
