//
//  AppMainSplitViewController.swift
//  MacDemo
//
//  Created by Laowang on 2023/8/21.
//

import Cocoa

class AppMainSplitViewController: NSSplitViewController {
    
    lazy var tableListViewController: NSViewController = {
        let vc = NSViewController()
        return vc
    }()
    
    lazy var appMainTabViewController: AppMainTabViewController = {
        let vc = AppMainTabViewController()
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.setUpControllers()
        self.configLayout()
        
        print("我拉也来了")
    }
    
    func setUpControllers() {
        self.addChild(self.tableListViewController)
        self.addChild(self.appMainTabViewController)
    }
    
    func configLayout() {
        
        //设置左边视图的宽度最小100,最大300
//        self.tableListViewController.view.width >= 100
//        self.tableListViewController.view.width <= 260

        //设置右边视图的宽度最小300,最大2000
//        self.appMainTabViewController.view.width >= 300
//        self.appMainTabViewController.view.width <= 2000
    }
}
