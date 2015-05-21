//
//  FilterDetailVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/12/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class FilterDetailVC: UITableViewController,UIGestureRecognizerDelegate {
    var options = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        self.navigationController?.interactivePopGestureRecognizer.delegate = self
        
        let backButton = UIBarButtonItem(title: "  Atrás", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
        backButton.tintColor = UIColor.orangeYI()
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Roboto-Regular", size: 16)!], forState: UIControlState.Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func goBack(){
        self.navigationController?.view.layer.addAnimation(CATransition.viewTransition(), forKey: nil)
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.textColor = UIColor.whiteColor()
        tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.lightGrayColor()
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.textColor = UIColor.blackColor()
        tableView.cellForRowAtIndexPath(indexPath)?.backgroundColor = UIColor.clearColor()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "")
        var jsonObj = options[indexPath.row]
        cell.textLabel?.text = jsonObj["name"].string
        cell.textLabel?.font = UIFont(name: "Roboto-Light", size: 20)
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return 0
    }
}
