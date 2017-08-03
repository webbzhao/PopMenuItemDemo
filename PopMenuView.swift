//
//  PopMenuView.swift
//  CustomItem
//
//  Created by WebbZhao on 17/8/2.
//  Copyright © 2017年 WebbZhao. All rights reserved.
//

import Foundation
import UIKit
typealias MenuClickedAction = (_ menuName:String) -> Void

class PopMenuView:UIView,UITableViewDelegate,UITableViewDataSource{
    
    var menusArr:Array<(String,String?)> = []
    let handler:MenuClickedAction?
    let CELLHEIGHT:CGFloat = 44
    var tableView:UITableView = UITableView()

    init(menusArr:Array<(menuName:String,imageName:String?)>,handler:@escaping MenuClickedAction) {
        self.menusArr = menusArr
        self.handler = handler
        let size = UIScreen.main.bounds.size
        super.init(frame: CGRect(x: 0, y: size.height*0.5, width: size.width, height: 0.1))
        let fullScreen = CGRect(x: 0, y: 0, width: size.width, height:  size.height)
        self .settingViewProperties(frame: fullScreen)
    }
    
    init(frame: CGRect,menusArr:Array<(menuName:String,imageName:String?)>,handler:@escaping MenuClickedAction) {
        self.menusArr = menusArr
        self.handler = handler
        super.init(frame: CGRect(x: 0, y: frame.size.height*0.5, width: frame.width, height: 0.1))
        self.settingViewProperties(frame: frame)
    }
    
    public func hideWithAnimation() -> Void{
        UIView.animate(withDuration: 0.2, animations:{
            self.frame = CGRect(x: 0, y: self.frame.size.height*0.5, width: self.frame.width, height: 1)
        }, completion: { b in
            self.frame = CGRect(x: 0, y: self.frame.size.height*0.5, width: self.frame.width, height: 1)
            self.isHidden = true
        })
    }
    
    
    private func settingViewProperties(frame:CGRect){
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        self.clipsToBounds = true
        self.addSubview(self.tableView)
        UIView.animate(withDuration: 0.2, animations: {
            self.frame = frame
        }, completion: { b in
            self.frame = frame
            self.redrawTableView()
        })
    }

    private func redrawTableView() -> Void {
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.layer.cornerRadius = 5
        self.tableView.bounces = false
        self.tableView.layer.masksToBounds = true
        self.tableView.center = CGPoint(x: frame.size.width*0.5, y:frame.size.height*0.5)
        self.tableView.bounds = CGRect(x: 0, y: 0, width:frame.size.width*0.65, height:min(CGFloat(self.menusArr.count)*CELLHEIGHT, frame.size.height))
        if CGFloat(self.menusArr.count)*CELLHEIGHT > frame.size.height{
            self.tableView.isScrollEnabled = true
        }else{
            self.tableView.isScrollEnabled = false
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menusArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELLHEIGHT
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "CellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style:.default, reuseIdentifier: CellIdentifier)
        }
        let (itemName,imageName) = self.menusArr[indexPath.row]
        cell!.textLabel?.text = itemName
        if imageName != nil {
            cell!.imageView?.image = UIImage(named: imageName!)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        if let handler = self.handler {
            let (itemName,_) = self.menusArr[indexPath.row]
            handler(itemName)
        }
        self.hideWithAnimation()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.hideWithAnimation()
    }
}
