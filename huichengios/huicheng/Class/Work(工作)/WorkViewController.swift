//
//  WorkViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let firstH = CGFloat(140)
let wotldFirstCellId = "wotldFirstCell_Id"

class WorkViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
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
        self.navigation_title_fontsize(name: "工作", fontsize: 18)
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
        mainTabelView.register(UINib.init(nibName: "WorkFirstTableViewCell", bundle: nil), forCellReuseIdentifier: wotldFirstCellId)
        
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
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : WorkFirstTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: wotldFirstCellId, for: indexPath) as! WorkFirstTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return firstH
        } else {
            return 0
        }
    }
    
    // MARK: - event response
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
