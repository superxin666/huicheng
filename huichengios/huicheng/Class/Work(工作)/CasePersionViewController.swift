//
//  CasePersionViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/4/13.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
typealias CasePersionViewControllerBlock = (_ pn:String,_ pc:String,_ pp:String,_ pz:String,_ pj:String,_ pd:String, _ pa:String)->()

enum CasePersionViewControllertype {
    //委托人                              对方当事人
    case principal_detail,principal_add, opposite_detail,opposit_add


}
class CasePersionViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,TitleTableViewCellDelegate {
    var type  : CasePersionViewControllertype!
    var nameArr : [String] = ["委托人","联系人","电话","邮编","职务","身份证号","联系地址",]
    var dataArr : Array<String> = []

    var alertController : UIAlertController!

    let mainTabelView : UITableView = UITableView()
    let request : WorkRequestVC = WorkRequestVC()
    var sureBlock : CasePersionViewControllerBlock!

    var pnStr : String = ""
    var pcStr : String = ""
    var ppStr : String = ""
    var pzStr : String = ""
    var pjStr : String = ""
    var pdStr : String = ""
    var paStr : String = ""
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
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))
        if type == .principal_detail {
            self.navigation_title_fontsize(name: "委托人情况", fontsize: 18)

        } else if type == .principal_add {
            self.navigation_title_fontsize(name: "委托人情况", fontsize: 18)
            self.navigationBar_rightBtn_title(name: "确定")
            dataArr.append(self.pnStr)
            dataArr.append(self.pcStr)
            dataArr.append( self.ppStr)
            dataArr.append(self.pzStr)
            dataArr.append(self.pjStr)
            dataArr.append( self.pdStr)
            dataArr.append(self.paStr)


        } else if type == .opposite_detail {
            self.navigation_title_fontsize(name: "对方当事人情况", fontsize: 18)
            nameArr.remove(at: 5)

        } else{
            self.navigation_title_fontsize(name: "对方当事人情况", fontsize: 18)
            self.navigationBar_rightBtn_title(name: "确定")
            nameArr.remove(at: 5)
            dataArr.append(self.pnStr)
            dataArr.append(self.pcStr)
            dataArr.append( self.ppStr)
            dataArr.append(self.pzStr)
            dataArr.append(self.pjStr)
            dataArr.append(self.paStr)

        }



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
        mainTabelView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: TitleTableViewCellID)
        self.view.addSubview(mainTabelView)
    }
    // MARK: - delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TitleTableViewCell  = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCellID, for: indexPath) as! TitleTableViewCell
        cell.delegate = self
        cell.tag = indexPath.row
        if indexPath.row < nameArr.count {
            cell.setData_caseDetail(titleStr: nameArr[indexPath.row], contentStr: dataArr[indexPath.row],indexPath : indexPath)
        }
        if type == .principal_detail || type == .opposite_detail{

            cell.isUserInteractionEnabled = false
        } else {
//            cell.setData_caseAdd(titleStr:  nameArr[indexPath.row], indexPath: indexPath)
            cell.isUserInteractionEnabled = true
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TitleTableViewCellH
    }


    func endEdite(inputStr: String, tagNum: Int) {
        HCLog(message: inputStr)
        HCLog(message: tagNum)
        if self.type == .principal_add {
            if tagNum == 0  {
                pnStr = inputStr
            } else if tagNum == 1 {
                pcStr = inputStr
            } else if tagNum == 2 {
                ppStr = inputStr
            } else if tagNum == 3 {
                pzStr = inputStr
            } else if tagNum == 4 {
                pjStr = inputStr
            } else if tagNum == 5 {
                pdStr = inputStr
            } else if tagNum == 6 {
                paStr = inputStr
            }

        } else {
            if tagNum == 0  {
                pnStr = inputStr
            } else if tagNum == 1 {
                pcStr = inputStr
            } else if tagNum == 2 {
                ppStr = inputStr
            } else if tagNum == 3 {
                pzStr = inputStr
            } else if tagNum == 4 {
                pjStr = inputStr
            } else if tagNum == 5 {
                paStr = inputStr
            }
        }
    }

    override func navigationLeftBtnClick() {
        alertController = UIAlertController(title: nil, message: "是否放弃本次记录", preferredStyle: .alert)
        let actcion1 = UIAlertAction(title: "确定", style: .default) { (aciton) in
            self.navigationController?.popViewController(animated: true)
        }
        let actcion2 = UIAlertAction(title: "取消", style: .cancel) { (aciton) in
            self.alertController.dismiss(animated: true, completion: {

            })
        }
        alertController.addAction(actcion1)
        alertController.addAction(actcion2)
        self.present(alertController, animated: true, completion: nil)


    }
    override func navigationRightBtnClick() {
        HCLog(message: "确定")
        self.view.endEditing(true)
        self.sureBlock(self.pnStr ,self.pcStr  ,self.ppStr, self.pzStr,self.pjStr,self.pdStr, self.paStr)
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
