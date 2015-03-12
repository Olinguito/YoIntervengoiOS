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
        println("Entra ")
        performGet("Reports", token: "", list: true)
        println("Entra ")
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
    /*
    -(void) performGet:(NSString*)url :(NSString*)token :(BOOL)list{
    //if (![token isEqualToString:@""]) {
    NSLog(@"Performing Get with URL: %@",[NSString stringWithFormat:@"%@%@",URLAPI,url]);
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[operationManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    [operationManager GET:[NSString stringWithFormat:@"%@%@",URLAPI,url] parameters:nil
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"Sirveee: %@", responseObject);
    if (list) {
    [self.delegate returnList:responseObject :url];
    }else{
    [self.delegate returnObt:responseObject];
    }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", [error description]);
    //[self.delegate loaded:false :@"Información incorrecta. Por favor revise los campos" :@""];
    }
    ];
    //}
    }
    
    */
    
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
