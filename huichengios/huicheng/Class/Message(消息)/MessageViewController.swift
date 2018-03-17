//
//  MessageViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
let MESSAGEID = "MESSAGE_ID"
let cell_height = ip6(80)

class MessageViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    /// 列表
    let mainTabelView : UITableView = UITableView()
    
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
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MessageTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: MESSAGEID, for: indexPath) as! MessageTableViewCell
//        if (cell == nil)  {
//            cell = MessageTableViewCell(style: .default, reuseIdentifier: MESSAGEID)
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cell_height
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
