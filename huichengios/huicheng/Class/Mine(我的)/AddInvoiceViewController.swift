//
//  AddInvoiceViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/31.
//  Copyright © 2018年 lvxin. All rights reserved.
//  添加发票

import UIKit

class AddInvoiceViewController: BaseViewController,UITableViewDataSource, UITableViewDelegate , MineRequestVCDelegate {
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

        self.navigation_title_fontsize(name: "发票申请", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        self.navigationBar_rightBtn_title(name: "确定")
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
        mainTabelView.register(UINib.init(nibName: "InvoiceTableViewCell", bundle: nil), forCellReuseIdentifier: InvoiceTableViewCellID)
        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : InvoiceTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: InvoiceTableViewCellID, for: indexPath) as! InvoiceTableViewCell

        return cell
    }
    // MARK: - net
    func requestFail_mine() {

    }
    func requestSucceed_mine(data: Any, type: MineRequestVC_enum) {

    }

    override func navigationRightBtnClick() {
        HCLog(message: "确定")
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
