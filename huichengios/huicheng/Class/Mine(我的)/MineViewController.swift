//
//  MineViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/3/5.
//  Copyright © 2018年 lvxin. All rights reserved.
//   我的

import UIKit
let MINEID = "MINE_ID"
let mine_cell_height = CGFloat(60)
class MineViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,MineHeadViewDelegate,MineRequestVCDelegate,MineFooterViewDelegate {

    /// 列表
    let mainTabelView : UITableView = UITableView()
    
    /// 头部b
    let headView : MineHeadView = MineHeadView.loadNib()
    /// 底部
    let footerView : MineFooterView = MineFooterView.loadNib()
    
    let request : MineRequestVC = MineRequestVC()
    
    var model : user_getinfoModel = user_getinfoModel()
    
    
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
        self.navigation_title_fontsize(name: "我的", fontsize: 18)
        self.creatUI()
        headView.delegate = self
        footerView.delegate = self
        request.delegate = self
        request.user_getinfoRequest()
        
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
        mainTabelView.register(UINib.init(nibName: "MineTableViewCell", bundle: nil), forCellReuseIdentifier: MINEID)
        self.view.addSubview(mainTabelView)
    }
    
    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MineTableViewCell!  = tableView.dequeueReusableCell(withIdentifier: MINEID, for: indexPath) as! MineTableViewCell
        cell.setData(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            //备忘录
            let vc = MemoViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            //报销申请
            let vc = SubmitPayViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)

        case 2:
            //发票申请
            let vc = InvoiceViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)

        case 3:
            //我的收款
            let vc = IncomeViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            //工作日志
            let vc = WorkBookViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)

        default:
            HCLog(message: "咩有")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return mine_cell_height
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    func iconClick() {
        let vc = InfoViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func viewTap() {
        let vc = SetViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func requestSucceed(data: Any,type : MineRequestVC_enum) {
        model = data as! user_getinfoModel
        headView.setData(model: model)
    }
    func requestFail() {
        
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
