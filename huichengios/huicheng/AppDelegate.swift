//
//  AppDelegate.swift
//  huicheng
//
//  Created by lvxin on 2018/2/22.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?
    var tab : UITabBarController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        self.showMain()
        self.showLogin()
        return true
    }
    
    
    func showLogin()  {
        let vc = LogInViewController()
        self.window?.rootViewController = vc
    }
    
    /// tab
    func showMain()  {
        //消息
        let mesVc :MessageViewController = MessageViewController()
        let mesNv :UINavigationController = UINavigationController(rootViewController: mesVc)
        let item1:UITabBarItem = UITabBarItem(title:"消息", image:UIImage.init(named: "")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage.init(named: "")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        mesNv.tabBarItem = item1
        
        //工作
        let workVc :WorkViewController = WorkViewController()
        let workNv :UINavigationController = UINavigationController(rootViewController: workVc)
        let item2:UITabBarItem = UITabBarItem(title:"工作", image:UIImage.init(named: "")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage.init(named: "")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        workNv.tabBarItem = item2
        
        //便捷
        let convenVc :ConvenViewController = ConvenViewController()
        let convenNv :UINavigationController = UINavigationController(rootViewController: convenVc)
        let item3:UITabBarItem = UITabBarItem(title:"便捷", image:UIImage.init(named: "")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage.init(named: "")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        convenNv.tabBarItem = item3
        
        //我的
        let minVc :MineViewController = MineViewController()
        let minNv :UINavigationController = UINavigationController(rootViewController: minVc)
        let item4:UITabBarItem = UITabBarItem(title:"我的", image:UIImage.init(named: "")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage.init(named: "")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        minNv.tabBarItem = item4
        
        
        
        let vcArr = [mesNv,workNv,convenNv,minNv]
        tab = UITabBarController()
//        tab.tabBar.barTintColor = blue_COLOUR
        tab.delegate = self
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.white], for: .selected)
        tab.viewControllers = vcArr
        self.window?.rootViewController = tab
    }

}

