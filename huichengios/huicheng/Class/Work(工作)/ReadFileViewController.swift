//
//  RedFileViewController.swift
//  huicheng
//
//  Created by lvxin on 2018/5/25.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import QuickLook

class ReadFileViewController: QLPreviewController,QLPreviewControllerDelegate,QLPreviewControllerDataSource {

    var fileUrl : String!
//    init(url : String) {
//        super
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    func jump(vc : UIViewController) {
        self.delegate = self
        self.dataSource = self
        vc.navigationController?.pushViewController(self, animated: true)
        self.reloadData()
    }

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let url = URL(fileURLWithPath: fileUrl)
        return url as QLPreviewItem
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
