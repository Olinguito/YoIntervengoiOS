//
//  FilterMasterVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/12/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit
import SwiftyJSON

class FilterMasterVC: UITableViewController,APIManagerDelegate {
    var APIManagerClass:APIManager!
    var filters = [JSON]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIManagerClass = APIManager()
        APIManagerClass.delegate = self
        APIManagerClass.getFilter()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detail = FilterDetailVC()
        var jsonObj = filters[indexPath.row]
        detail.options = jsonObj["data"].array!
        print(detail.options)
        self.navigationController?.view.layer.addAnimation(CATransition.viewTransition(), forKey: nil)
        self.navigationController?.pushViewController(detail, animated: false)
    }
    
    func returnObt(responseObject:AnyObject, url:String){
        var json = JSON(data: responseObject as! NSData)
        for filter in json["filters"]{
            filters.append(filter.1)
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "")
        var jsonObj = filters[indexPath.row]
        cell.textLabel?.text = jsonObj["name"].string
        cell.textLabel?.font = UIFont(name: "Roboto-Light", size: 20)
        cell.tintColor = UIColor.blackColor()
        cell.backgroundColor = UIColor.clearColor()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    override func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return 0
    }
    
    /*override func tableView(tableView: UITableView, accessoryTypeForRowWithIndexPath indexPath: NSIndexPath!) -> UITableViewCellAccessoryType {
     UITableViewCellAccessoryType.DisclosureIndicator
     }*/
    func percentageDownloaded(dataDownloaded:Double){}
    func loadedImage(imageLoaded:UIImage){}
    func loaded(checker:Bool,msg:NSString,tokenR:NSString){}
    func returnResponse(msg:String,response:AnyObject){}
    func returnList(responseObject:AnyObject, url:String){}
    func returnBool(response:Bool){}
    func returnError(url:String){}
    
}
