//
//  FilterMasterVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/12/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class FilterMasterVC: UITableViewController,UITableViewDelegate,APIManagerDelegate {
    var APIManagerClass:APIManager!
    var filters:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManagerClass = APIManager()
        APIManagerClass.delegate = self
        APIManagerClass.getFilter()
        // Do any additional setup after loading the view.
    }
    
    /*override func viewDidAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }*/

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var detail = FilterDetailVC()
        self.navigationController?.view.layer.addAnimation(CATransition.viewTransition(), forKey: nil)
        self.navigationController?.pushViewController(detail, animated: false)
    }
    
    func returnObt(responseObject:AnyObject, url:String){
        //print(responseObject)
        var json = JSON(data: responseObject as! NSData)
        
//        print(json["filters"])
        
        for filter in json["filters"]{
            println(filter.1["name"])
            println(filter.1["data"][0]["name"])
            println("----")
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
