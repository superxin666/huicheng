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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigation_title_fontsize(name: "函件查询", fontsize: 18)


    }

    func navigation_title_fontsize(name:String, fontsize:Int, textColour:UIColor = darkblueColor) {
        self.title = name
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: ip6(fontsize))]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: textColour]
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
