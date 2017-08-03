//
//  ViewController.swift
//  PopMenuItemDemo
//
//  Created by WebbZhao on 17/8/3.
//  Copyright © 2017年 WebbZhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "弹出菜单展示"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func menuBtnClicked(_ sender: UIButton) {
        let menuView = PopMenuView(menusArr: [("复制",nil),("更改",nil),("插入",nil),("取消",nil)]){
            menuName in
            print("您点击了\(menuName)功能")
        }
        self.navigationController?.view .addSubview(menuView)
    }
}

