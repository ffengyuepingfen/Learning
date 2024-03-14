//
//  AppMainTabViewController.swift
//  MacDemo
//
//  Created by Laowang on 2023/8/21.
//

import Cocoa

class AppMainTabViewController: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.addChildViewControllers()
    }
    func addChildViewControllers() {
        
        let dataViewController = NSViewController()
        dataViewController.title = "Browse"
        
        let schemaViewController = NSViewController()
        schemaViewController.title = "Schema"
        
        let queryViewController = NSViewController()
        queryViewController.title = "Query"
        
        self.addChild(dataViewController)
        self.addChild(schemaViewController)
        self.addChild(queryViewController)
    }
    
    
    override func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
        super.tabView(tabView, didSelect: tabViewItem)
        print("didSelectTabViewItem \(tabViewItem!)")
        
//        TableListStateManager.shared.multiDelegate.selectedTableChanged()
        
    }
}
