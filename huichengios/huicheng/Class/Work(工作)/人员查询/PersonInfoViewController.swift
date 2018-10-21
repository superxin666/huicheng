//
//  PersonInfoViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/10/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//  人员信息

import UIKit

class PersonInfoViewController: BaseViewController ,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,Work2RequestVCDelegate{

    var id : String!
    let requestVC = Work2RequestVC()

    var colletionView : UICollectionView!
    var collectionSatateArr = ["1","0","0","0","0","0","0"]


    let headArr = ["基本信息","扩展信息","教育培训","奖惩信息","社保情况","合同信息","附件信息"]
    let nameArr = ["头像","姓名","账号","分所","部门","角色","性别","出生日期","学历","籍贯","政治面貌","身份证号","手机号","家庭电话","微信号","身份证地址","实际地址","档案所在","状态","入职时间","离职时间","职能设定",]
    var contentArr : [String] = []


    let sectionHeadNameArr1 = ["家庭成员/紧急联系人","银行信息","证件扫描","律师执业信息",]


    let sectionHeadNameArr3 = ["技能特长","教育经历","培训经历",]


    var scrView : UIScrollView!

    let mainTabelView : UITableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)

    var mainTabelView1 : UITableView!
    var mainTabelView2 : UITableView!
    var mainTabelView3 : UITableView!
    var mainTabelView4 : UITableView!
    var mainTabelView5 : UITableView!
    var mainTabelView6 : UITableView!

    //当前数据源
    
    var showNum = 0

    var dataModel : usermanageInfoModel = usermanageInfoModel()






    override func viewWillLayoutSubviews() {
        colletionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(LNAVIGATION_HEIGHT)
            make.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(60)
        }
//        scrView.snp.makeConstraints { (make) in
//            make.top.equalTo(colletionView).offset(70)
//            make.left.right.equalTo(self.view).offset(0)
//            make.bottom.equalTo(self.view).offset(0)
//        }
        mainTabelView.snp.makeConstraints { (make) in
            make.top.equalTo(colletionView).offset(70)
            make.left.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }


    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = viewBackColor

        self.navigation_title_fontsize(name: "人员信息", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))

        // Do any additional setup after loading the view.
        self.creatUI()
        self.creTab()
        self.requestApi()
//        self.creatScr()

    }

    func creatUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: iteamW, height: iteamH)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0


        colletionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        colletionView.register(UINib(nibName: "PersonHeadCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PersonHeadCollectionViewCellId)

        colletionView.backgroundColor = .clear
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.showsVerticalScrollIndicator = false
        colletionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(colletionView)

    }


    func creatScr() {
        scrView = UIScrollView(frame: CGRect.zero)
        scrView.contentSize = CGSize(width: KSCREEN_WIDTH * 7, height: KSCREEN_HEIGHT - 70)
        scrView.backgroundColor = .red
        scrView.showsVerticalScrollIndicator = false
        scrView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrView)

    }

    func creTab() {
        mainTabelView.backgroundColor = UIColor.clear
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
        mainTabelView.tableFooterView = UIView()
        mainTabelView.separatorStyle = .none
        mainTabelView.showsVerticalScrollIndicator = false
        mainTabelView.showsHorizontalScrollIndicator = false
        mainTabelView.backgroundView?.backgroundColor = .clear

        mainTabelView.register(UINib.init(nibName: "Title4TableViewCell", bundle: nil), forCellReuseIdentifier: Title4TableViewCellID)
        mainTabelView.register(UINib.init(nibName: "IconTableViewCell", bundle: nil), forCellReuseIdentifier: IconTableViewCellId)
        mainTabelView.register(UINib.init(nibName: "FamilyTableViewCell", bundle: nil), forCellReuseIdentifier: FamilyTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "BankInfoTableViewCell", bundle: nil), forCellReuseIdentifier: BankInfoTableViewCellID)
        mainTabelView.register(UINib.init(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: ImageTableViewCellID)




        self.view.addSubview(mainTabelView)

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell :PersonHeadCollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: PersonHeadCollectionViewCellId, for: indexPath) as! PersonHeadCollectionViewCell
        cell.setData(title: headArr[indexPath.row], selected: collectionSatateArr[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HCLog(message: indexPath.row)
        collectionSatateArr[showNum] = "0"
        showNum = indexPath.row
        collectionSatateArr[showNum] = "1"
        self.colletionView.reloadData()
        self.mainTabelView.reloadData()



    }

    // MARK: - delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if showNum == 0 {
            return 1
        } else if showNum == 1 {
            return 4
        } else if showNum == 2 {
            return 3
        }
        else {
            return 0
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showNum == 0 {
            return nameArr.count
        } else if showNum == 1 {
            if section == 0 {
                return dataModel.info2.family.count
            } else if section == 1 {
                return 1
            } else if section == 2 {
                return 3
            } else {
                return 1
            }
        } else if showNum == 2 {
            if section == 0 {
                return 2
            } else if section == 1 {
                return self.dataModel.info3.school.count
            } else {
                return self.dataModel.info3.train.count
            }
        }

        else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showNum == 0 {
            if indexPath.row == 0 {
                let cell : IconTableViewCell  = tableView.dequeueReusableCell(withIdentifier: IconTableViewCellId, for: indexPath) as! IconTableViewCell
                if indexPath.row < contentArr.count {
                    cell.setData(nameStr: nameArr[indexPath.row], iconStr: contentArr[indexPath.row])

                }
                return cell

            } else {
                let cell : Title4TableViewCell  = tableView.dequeueReusableCell(withIdentifier: Title4TableViewCellID, for: indexPath) as! Title4TableViewCell
                cell.backgroundColor = .white
                if indexPath.row < contentArr.count {
                    cell.setData_personInfo(titleStr: nameArr[indexPath.row], contentStr: contentArr[indexPath.row])
                }
                return cell

            }
        }


        else if showNum == 1 {
            if indexPath.section == 0 {
                let cell : FamilyTableViewCell  = tableView.dequeueReusableCell(withIdentifier: FamilyTableViewCellID, for: indexPath) as! FamilyTableViewCell
                if indexPath.row < self.dataModel.info2.family.count {
                    let model = self.dataModel.info2.family[indexPath.row]
                    cell.setData(model: model)
                }
                return cell
            } else if indexPath.section == 1 {
                let cell : BankInfoTableViewCell  = tableView.dequeueReusableCell(withIdentifier: BankInfoTableViewCellID, for: indexPath) as! BankInfoTableViewCell
                cell.setData2(model: self.dataModel.info2)
                return cell
            } else if indexPath.section == 2 {
                let cell : ImageTableViewCell  = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCellID, for: indexPath) as! ImageTableViewCell
                if indexPath.row == 0 {
                    cell.setData(titleStr: "身份证 ", imageStr: self.dataModel.info2.cardimg)
                } else if indexPath.row == 1 {
                    cell.setData(titleStr: "学历证 ", imageStr: self.dataModel.info2.diplomaimg)

                } else {
                    cell.setData(titleStr: "资格证 ", imageStr: self.dataModel.info2.jobimg)

                }

                return cell
            } else if indexPath.section == 3 {
                let cell : BankInfoTableViewCell  = tableView.dequeueReusableCell(withIdentifier: BankInfoTableViewCellID, for: indexPath) as! BankInfoTableViewCell
                cell.setData(model: self.dataModel.info2)
                return cell

            } else {
                return UITableViewCell()
            }
        } else if showNum == 2 {
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    let cell : FamilyTableViewCell  = tableView.dequeueReusableCell(withIdentifier: FamilyTableViewCellID, for: indexPath) as! FamilyTableViewCell
                        cell.setData1(model: self.dataModel.info3)
                    return cell
                } else {
                    let cell : BankInfoTableViewCell  = tableView.dequeueReusableCell(withIdentifier: BankInfoTableViewCellID, for: indexPath) as! BankInfoTableViewCell
                    cell.setData3(model: self.dataModel.info3)
                    return cell
                }

            } else if indexPath.section == 1 {
                let cell : FamilyTableViewCell  = tableView.dequeueReusableCell(withIdentifier: FamilyTableViewCellID, for: indexPath) as! FamilyTableViewCell
                if indexPath.row < self.dataModel.info3.school.count {
                    let model = self.dataModel.info3.school[indexPath.row]
                    cell.setData2(model: model)
                }
                return cell


            } else {
                let cell : BankInfoTableViewCell  = tableView.dequeueReusableCell(withIdentifier: BankInfoTableViewCellID, for: indexPath) as! BankInfoTableViewCell
                if indexPath.row < self.dataModel.info3.school.count {
                    let model = self.dataModel.info3.train[indexPath.row]
                    cell.setData4(model: model)
                }
                return cell

            }

        }
        else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if showNum == 0 {
            if indexPath.row == 0 {
                return IconTableViewCellH
            } else {
                return Title4TableViewCellH
            }
        } else if showNum == 1 {
            if indexPath.section == 0 {
                return FamilyTableViewCellH
            } else if indexPath.section == 1 {
                return BankInfoTableViewCellH
            } else if indexPath.section == 2 {
                return ImageTableViewCellH
            } else {
                return BankInfoTableViewCellH
            }
        } else if showNum == 2 {
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    return FamilyTableViewCellH
                } else {
                    return BankInfoTableViewCellH
                }
            } else if indexPath.section == 1 {
                return FamilyTableViewCellH
            } else {
                return BankInfoTableViewCellH
            }
        }

        else {

            return 0
        }
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if showNum == 0 {
            return UIView()
        } else if showNum == 1 {
            let headView = PersonHeadView.loadNib()
            headView.setData(titleStr: sectionHeadNameArr1[section])
            return headView

        } else if showNum == 2 {
            let headView = PersonHeadView.loadNib()
            headView.setData(titleStr: sectionHeadNameArr3[section])
            return headView
        }

        else {
            return UIView()
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if  showNum == 0 {
            return 0
        } else if showNum == 1 {
            return  60
        } else if showNum == 2 {
            return 60
        }
        else {
            return 0 
        }
    }


    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if showNum == 0 {
            return UIView()
        } else if showNum == 1 {
            let view : UIView = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: CGFloat(20)))
            view.backgroundColor = viewBackColor
            return view
        } else if showNum == 2 {
            let view : UIView = UIView(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: CGFloat(20)))
            view.backgroundColor = viewBackColor
            return view
        }  else {
            return UIView()
        }
    }


    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if  showNum == 0 {
            return 0
        } else if showNum == 1 {
            return  20
        }else if showNum == 2 {
            return  20
        } else {
            return 0
        }

    }

    // MARK: - net
    func requestApi() {
        requestVC.delegate = self
        requestVC.usermanageInfo(id: id)
    }


    func requestSucceed_work2(data: Any,type : Work2RequestVC_enum) {

        dataModel  = data as! usermanageInfoModel

        contentArr.append(dataModel.info1.headimg)
        contentArr.append(dataModel.info1.name)
        contentArr.append(dataModel.info1.username)
        contentArr.append(dataModel.info1.branch)
        contentArr.append(dataModel.info1.department)
        contentArr.append(dataModel.info1.role)
        contentArr.append(dataModel.info1.sex)
        contentArr.append(dataModel.info1.birthday)
        contentArr.append(dataModel.info1.diploma)

        contentArr.append(dataModel.info1.hometown)
        contentArr.append(dataModel.info1.political)
        contentArr.append(dataModel.info1.idcard)
        contentArr.append(dataModel.info1.mobile)
        contentArr.append(dataModel.info1.phone)
        contentArr.append(dataModel.info1.weixin)
        contentArr.append(dataModel.info1.regaddr)
        contentArr.append(dataModel.info1.addr)
        contentArr.append(dataModel.info1.recordwhere)

        contentArr.append(dataModel.info1.state)
        contentArr.append(dataModel.info1.intime)
        contentArr.append(dataModel.info1.outtime)
        contentArr.append(dataModel.info1.isls)



        self.mainTabelView.reloadData()
    }



    func requestFail_work2() {

    }


    override func navigationLeftBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
