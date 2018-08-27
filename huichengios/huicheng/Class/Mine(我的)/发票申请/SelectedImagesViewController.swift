//
//  SelectedImagesViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/27.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

class SelectedImagesViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    /// 列表
    let mainTabelView : UITableView = UITableView()

    let nameArr : [String] = ["税务登记证","组织机构代码（副本）","开户许可证","营业执照（副本）","一般纳税人资格认定书",]


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

        self.navigation_title_fontsize(name: "相关附件", fontsize: 18)
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
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : InvoiceTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: InvoiceTableViewCellID, for: indexPath) as! InvoiceTableViewCell
//        if indexPath.row < dataArr.count {
//            cell.setData(model: dataArr[indexPath.row])
//        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return InvoiceViewTableViewCellH
    }

    // MARK: - event response
    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
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
