//
//  PersonInfoViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/10/19.
//  Copyright © 2018年 lvxin. All rights reserved.
//  人员信息

import UIKit

class PersonInfoViewController: BaseViewController {

    var id : String!
    let requestVC = Work2RequestVC()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigation_title_fontsize(name: "人员信息", fontsize: 18)
        self.navigationBar_leftBtn_image(image: #imageLiteral(resourceName: "pub_arrow"))

        // Do any additional setup after loading the view.
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
