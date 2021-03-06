//
//  PubMessageViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/17.
//  Copyright © 2018年 lvxin. All rights reserved.
//  公告

import UIKit
let PUBMESSAGEID = "PUBMESSAGE_ID"
let pub_cell_height = ip6(129)

class PubMessageViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,PubMessageTableViewCellDelegate,MessageRequestVCDelegate {
    /// 列表
    let mainTabelView : UITableView = UITableView()
    let request = MessageRequestVC()
    var dataArr : [newslistModel] = []
    
    
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

        // Do any additional setup after loading th     e view.
        self.view.backgroundColor = viewBackColor
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigation_title_fontsize(name: "公告", fontsize: 18)
        self.creatUI()
        request.delegate = self
        request.newslistRequest(p: 1)
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
        mainTabelView.register(UINib.init(nibName: "PubMessageTableViewCell", bundle: nil), forCellReuseIdentifier: PUBMESSAGEID)
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
        let cell : PubMessageTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: PUBMESSAGEID, for: indexPath) as! PubMessageTableViewCell
        cell.delegate = self
        cell.selectionStyle = .none
        if indexPath.row < dataArr.count {
            cell.setData(model: dataArr[indexPath.row])
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.dataArr.count {
            let model = self.dataArr[indexPath.row]
            let vc = PubMessageConViewController()
            vc.newsID = model.id
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return pub_cell_height
    }
    func redMessage(model: newslistModel) {
        let vc = PubMessageConViewController()
        vc.newsID = model.id
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func requestSucceed_message(data: Any) {
        dataArr = data as! [newslistModel]
        HCLog(message: dataArr.count)
        mainTabelView.reloadData()
    }
    func requestFail_message() {
        
    }
    // MARK: - event reponse
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
