//
//  Work2ViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/8/11.
//  Copyright © 2018年 lvxin. All rights reserved.
//  工作 平台

import UIKit
let iteamW :CGFloat = ip6(80)
let iteamH :CGFloat = ip6(60)
let Work2ViewController_id = "Work2ViewController_id"
class Work2ViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var colletionView : UICollectionView!
    var userDataModel : LoginModel!


    override func viewWillLayoutSubviews() {
        colletionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(0)
            make.left.right.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "mes_logo"))
        self.navigation_title_fontsize(name: "工作", fontsize: 18)

        HCLog(message: "数据模型")
        userDataModel = UserInfoLoaclManger.getsetUserWorkData()
        HCLog(message: userDataModel?.power.count)

        self.creatUI()
        

    }

    func creatUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: iteamW, height: iteamH)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = (KSCREEN_WIDTH - (4 * iteamW))/5
        layout.minimumLineSpacing = ip6(25)

        layout.headerReferenceSize = CGSize(width: KSCREEN_WIDTH, height: ip6(65))

        layout.footerReferenceSize = CGSize(width: KSCREEN_WIDTH, height: ip6(15))

        colletionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        colletionView.register(UINib(nibName: "WorkCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Work2ViewController_id)

        colletionView.register(WorlkHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")


        colletionView.register(WorkFootView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footView")

        colletionView.backgroundColor = .clear
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.showsVerticalScrollIndicator = false
        colletionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(colletionView)
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (userDataModel?.power.count)! - 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model : LoginModel_power = (userDataModel?.power[section])!
        return model.childrens.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell :WorkCollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: Work2ViewController_id, for: indexPath) as! WorkCollectionViewCell
        if indexPath.section < userDataModel.power.count {
            let model  = userDataModel.power[indexPath.section]
            let name = model.childrens[indexPath.row]
            cell.setData(name: name)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        HCLog(message: kind)

        if kind ==  UICollectionElementKindSectionHeader{
            let view : WorlkHeadView = colletionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView", for: indexPath) as! WorlkHeadView
            view.backgroundColor = .clear

            if indexPath.section < userDataModel.power.count {
                let model  : LoginModel_power = userDataModel.power[indexPath.section]
                view.creatUI(name: model.name!, sectionNum: indexPath.section)
            }
            return view
        } else if kind ==  UICollectionElementKindSectionFooter{

            let view : WorkFootView = colletionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footView", for: indexPath) as! WorkFootView
            view.creatUI()
            return view

        } else {

            return UIView() as! UICollectionReusableView
        }

    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section < userDataModel.power.count {

            let model  : LoginModel_power = userDataModel.power[indexPath.section]
            let name = model.childrens[indexPath.row]
            switch name {
            case "利益冲突查询" :
                HCLog(message: "利益冲突查询")
                let vc = CheckcaseViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "案件登记" :
                HCLog(message: "案件登记")
                let vc = CaseDetailViewController()
                vc.type = .addCase
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "案件管理" :
                HCLog(message: "案件管理")
                let vc = CaseViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)

            case "合同管理" :
                HCLog(message: "合同管理")
                let vc = DealViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "合同审核" :
                HCLog(message: "合同审核")
                let vc = DealCheckViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "结案审核" :
                HCLog(message: "结案审核")
                let vc = CaseCheckViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "合同查询" :
                HCLog(message: "合同查询")
                let vc = DealSearchViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "诉讼案件" :
                HCLog(message: "诉讼案件")
                let vc = CrtDealslistViewController()
                vc.viewType = .type1
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "非诉案件" :
                HCLog(message: "非诉案件")
                let vc = CrtDealslistViewController()
                vc.viewType = .type2
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "刑事案件" :
                HCLog(message: "刑事案件")

                let vc = CrtDealslistViewController()
                vc.viewType = .type3
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "法律顾问" :
                HCLog(message: "法律顾问")
                let vc = CrtDealslistViewController()
                vc.viewType = .type4
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "函件管理" :
                HCLog(message: "函件管理")
                let vc = DocViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "函件审核" :
                HCLog(message: "函件审核")
                let vc = DocApplylistViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "函件查询" :
                HCLog(message: "函件查询")
                let vc = DocSearchViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "收款登记" :
                HCLog(message: "收款登记")
                let vc : IncomeListViewController = IncomeListViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)

            case "收款审核" :
                HCLog(message: "收款审核")
            case "发票审核" :
                HCLog(message: "发票审核")
                let vc = InvoiceapplylisViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "报销审核" :
                HCLog(message: "报销审核")
                let vc = ExpenseapplylistViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "线下支付" :
                HCLog(message: "线下支付")
                let vc = PayApplylistViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "支付审核" :
                HCLog(message: "支付审核")
                let vc = PayCheckViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "银行信息" :
                HCLog(message: "银行信息")
                let vc = BankInfoViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "发布公告" :
                HCLog(message: "发布公告")
                let vc = NoticeViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "会议室预约" :
                HCLog(message: "会议室预约")
                HCLog(message: "会议室预约")
                let vc = RoomViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "共享模板" :
                HCLog(message: "共享模板")
                let vc = ShareViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            case "统计报表" :
                HCLog(message: "统计报表")
                let vc = StatisticsViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                HCLog(message: "暂无")
            }
        }

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
