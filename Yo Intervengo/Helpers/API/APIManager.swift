//
//  APIManager.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 3/10/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit


@objc protocol APIManagerDelegate{
    optional func percentageDownloaded(dataDownloaded:Double)
    optional func loadedImage(imageLoaded:UIImage)
    optional func loaded(checker:Bool,msg:NSString,tokenR:NSString)
    optional func returnResponse(msg:String,response:AnyObject)
    optional func returnList(responseObject:AnyObject, url:String)
    optional func returnObt(responseObject:AnyObject)
    optional func returnBool(response:Bool)
}

class APIManager: NSObject {
    var URLAPI = "http://api.yointervengo.co/v1/"
    var delegate:APIManagerDelegate!
    
    override init() {
        super.init()
    }
    
    //MARK: -LOGIN
    func logginEmail(username:String!,password:String!){
        
    }
    
    func logginFB(token:String!){
        
    }
    
    func logginGPlus(token:String!){
        
    }
    
    func logout(){
    
    }
    
    //MARK: -ACCOUNT
    func createAccount(){
    
    }
    
    func editAccount(){
        
    }
    
    func getMe(){
        
    }
    
    //MARK:-REPORT
    func getReports(){
        performGet("Reports", token: "", list: true)
    }
    
    func getReportWithID(idReport:String){
        performGet("Reports/?filter[include]=history-nodes&filter[include]=links&filter[where][id]=" + idReport, token: "", list: false)
    }
    
    func postReport(data:NSDictionary!){
        performPost("Reports", token: "", data: data, list: true, successMsg: "Creado datisfactoriamente", failMsg: "Ocurrio un error, intente más tarde.")
    }
    
    func followReport(){
    
    }
    
    //MARK: -LINKS
    func postLink(){
        
    }
    
    //MARK: -PICTURES
    func postPic(){
        
    }
    
    //MARK: -SPAM
    func postSpam(){
        
    }

    //MARK: -AFNETWORKING DELEGATE
    func performGet(url:String!, token:String!, list:Bool){
        var operationManager = AFHTTPRequestOperationManager()
        operationManager.responseSerializer = AFJSONResponseSerializer()
        operationManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        //[operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        println(URLAPI+url)
        operationManager.GET(URLAPI+url, parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                if list{
                    self.delegate.returnList!(responseObject, url: "url")
                }else{
                    self.delegate.returnObt!(responseObject)
                }
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }
    
    func performPost(url:String!, token:String!, data:NSDictionary, list:Bool, successMsg:String, failMsg:String){
        var operationManager = AFHTTPRequestOperationManager()
        operationManager.requestSerializer  = AFJSONRequestSerializer()
        operationManager.responseSerializer = AFJSONResponseSerializer()
        operationManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        //[operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        print(data)
        operationManager.POST(URLAPI+url, parameters: data, success:  { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println(responseObject.description)
                let responseDict = responseObject as! Dictionary<String, AnyObject>
                var token = responseDict["token"] as! String!
                println("Exitosoooo!!")
            }, failure:  { (operation: AFHTTPRequestOperation!, error: NSError!) in
                print(error)
                print("Hola mundo ocurrio un error")
            })
    }
    
    func performPut(url:String!, token:String!, data:NSDictionary, list:Bool, successMsg:String, failMsg:String){
        var operationManager = AFHTTPRequestOperationManager()
        // operationManager.requestSerializer  = AFJSONRequestSerializer()
        operationManager.responseSerializer = AFJSONResponseSerializer()
        operationManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        //[operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        print(URLAPI+url)
        operationManager.POST(URLAPI+url, parameters: nil, success:  { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            println(responseObject.description)
            let responseDict = responseObject as! Dictionary<String , AnyObject>
            var token = responseDict["token"] as! String!
            println(token)
            }, failure:  { (operation: AFHTTPRequestOperation!, error: NSError!) in
        })
    }
    
}
