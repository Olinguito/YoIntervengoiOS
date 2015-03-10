//
//  APIManager.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 3/10/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    var URLAPI = "http://api.yointervengo.co/v1/"
    
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
    
    func getReportWithID(){
    
    }
    
    func postReport(){
    
    }
    
    func followReport(){
    
    }
    
    //MARK: -TABBAR
    func getHistory(){
    
    }
    
    //MARK: -LINKS
    func getLinks(){
        
    }
    
    func postLink(){
        
    }
    
    //MARK: -PICTURES
    func getPics(){
        
    }
    
    func postPic(){
        
    }
    
    //MARK: -SPAM
    func postSpam(){
        
    }

    //MARK: -AFNETWORKING DELEGATE
    func performGet(url:String!, token:String!, list:Bool){
        println("MUNDAZOOO")
        var operationManager = AFHTTPRequestOperationManager()
       // operationManager.requestSerializer  = AFJSONRequestSerializer()
        operationManager.responseSerializer = AFJSONResponseSerializer()
        operationManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        //[operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
            operationManager.GET(url, parameters: nil, success:  { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                println("HOLA MUNDO")
                println(responseObject.description)
                println(responseObject)
                /*let responseDict = responseObject as Dictionary<String, AnyObject>
                var token = responseDict["token"] as String!
                println(token)*/
            }, failure:  { (operation: AFHTTPRequestOperation!, error: NSError!) in
        })
    }

    func performPost(url:String!, token:String!, data:NSDictionary, list:Bool, successMsg:String, failMsg:String){
        var operationManager = AFHTTPRequestOperationManager()
        // operationManager.requestSerializer  = AFJSONRequestSerializer()
        operationManager.responseSerializer = AFJSONResponseSerializer()
        operationManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        //[operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        operationManager.POST(url, parameters: nil, success:  { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            println(responseObject.description)
            let responseDict = responseObject as Dictionary<String, AnyObject>
            var token = responseDict["token"] as String!
            println(token)
            }, failure:  { (operation: AFHTTPRequestOperation!, error: NSError!) in
        })
    }
    
    func performPut(url:String!, token:String!, data:NSDictionary, list:Bool, successMsg:String, failMsg:String){
        var operationManager = AFHTTPRequestOperationManager()
        // operationManager.requestSerializer  = AFJSONRequestSerializer()
        operationManager.responseSerializer = AFJSONResponseSerializer()
        operationManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        //[operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        operationManager.POST(url, parameters: nil, success:  { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            println(responseObject.description)
            let responseDict = responseObject as Dictionary<String, AnyObject>
            var token = responseDict["token"] as String!
            println(token)
            }, failure:  { (operation: AFHTTPRequestOperation!, error: NSError!) in
        })
    }
    
}
