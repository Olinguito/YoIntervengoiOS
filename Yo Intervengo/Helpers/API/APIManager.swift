//
//  APIManager.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 3/10/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit
import MapKit

protocol APIManagerDelegate{
    func percentageDownloaded(dataDownloaded:Double)
    func loadedImage(imageLoaded:UIImage)
    func loaded(checker:Bool,msg:NSString,tokenR:NSString)
    func returnResponse(msg:String,response:AnyObject)
    func returnList(responseObject:AnyObject, url:String)
    func returnObt(responseObject:AnyObject, url:String)
    func returnBool(response:Bool)
    func returnError(url:String)
}

class APIManager: NSObject {
    var URLAPI = "http://api.yointervengo.co/v1/"
    //    var URLAPI = "http://10.0.1.203:3000/v1/"
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
        performGet("Reports", token: "", list: true, transac: "reports")
    }
    
    func getFilter(){
        getLocalJSON("filters", transac: "filters")
    }
    
    func getReportWithID(idReport:String){
        performGet("Reports/?filter[include]=history-nodes&filter[include]=links&filter[include]=pictures&filter[where][id]=" + idReport, token: "", list: false, transac: "report_detail")
    }
    
    func postReport(data:NSDictionary!){
        performPost("Reports", token: "", data: data, list: true, successMsg: "Creado datisfactoriamente", failMsg: "Ocurrio un error, intente más tarde.", transac: "Reports")
    }
    
    func postImage(image:UIImage){
        //        var operationManager =  AFHTTPRequestOperationManager() as AFHTTPRequestOperationManager
        //        operationManager.requestSerializer.setValue("Client-ID e84b4d7dc9700e0", forHTTPHeaderField: "Authorization")
        //        var imageData = UIImageJPEGRepresentation(image,0.5)
        //        operationManager.POST("https://api.imgur.com/3/image", parameters: nil, constructingBodyWithBlock: { (data: AFMultipartFormData!) in
        //            var res = data.appendPartWithFileData(imageData, name: "image", fileName: "upload", mimeType: "image/jpeg")
        //            print("was file added properly to the body? \(res)")
        //            }, success:  { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
        //                //let responseDict = responseObject as! Dictionary<String, AnyObject>
        //                self.delegate.returnObt!(responseObject, url: "image")
        //            }, failure:  { (operation: AFHTTPRequestOperation!, error: NSError!) in
        //                self.delegate.returnError!("image")
        //        })
    }
    
    func postNewImage(picture:Picture,report:Report){
        print("entra por aca a subir imagen? con id \(picture.urlImage)")
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let dateString = dateFormatter.stringFromDate(NSDate())
        let dataRep = ["description":report.desc,"url":picture.urlImage,"thumbUrl":picture.urlThumbImage,"date":dateString,"reportId":report.idAPI]
        performPost("Reports/"+report.idAPI+"/pictures", token: "", data: dataRep, list: false, successMsg: "Imagen posteada", failMsg: "Fallo en subida de imagen", transac: "Report_photo")
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
    
    func getLocalJSON(url:String!, transac: String!){
        //        var filePath =   NSBundle.mainBundle().pathForResource(transac, ofType: "json")
        //        var JSONData =   NSData.dataWithContentsOfMappedFile(filePath!) as! NSData
        //        //var jsonObject = NSJSONSerialization.JSONObjectWithData (JSONData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        //        var stringJSON = NSString(data:JSONData, encoding:NSUTF8StringEncoding) as! String
        //        self.delegate.returnObt!(JSONData, url:transac)
    }
    
    
    func nominatim(location:CLLocationCoordinate2D){
        //        var operationManager = AFHTTPRequestOperationManager()
        //        operationManager.responseSerializer = AFJSONResponseSerializer()
        //        operationManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        //        //[operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        //        operationManager.GET("http://nominatim.openstreetmap.org/reverse?lat=\(location.latitude)&lon=\(location.longitude)=json", parameters: nil,
        //                             success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
        //                                self.delegate.returnObt!(responseObject, url: "nominatim")
        //            },
        //                             failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
        //                                print("Error: " + error.localizedDescription)
        //        })
    }
    
    
    //MARK: -AFNETWORKING DELEGATE
    func performGet(url:String!, token:String!, list:Bool, transac: String!){
        //        var operationManager = AFHTTPRequestOperationManager()
        //        operationManager.responseSerializer = AFJSONResponseSerializer()
        //        operationManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        //        //[operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        //        operationManager.GET(URLAPI+url, parameters: nil,
        //                             success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
        //                                if list{
        //                                    self.delegate.returnList!(responseObject, url: transac)
        //                                }else{
        //                                    self.delegate.returnObt!(responseObject, url: transac)
        //                                }
        //            },
        //                             failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
        //                                print("Error: " + error.localizedDescription)
        //        })
    }
    
    func performPost(url:String!, token:String!, data:NSDictionary, list:Bool, successMsg:String, failMsg:String, transac:String){
        //        var operationManager = AFHTTPRequestOperationManager()
        //        operationManager.requestSerializer  = AFJSONRequestSerializer()
        //        operationManager.responseSerializer = AFJSONResponseSerializer()
        //        operationManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        //        //[operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        //        print("se fue con estos datos \(data)")
        //        operationManager.POST(URLAPI+url, parameters: data, success:  { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
        //            print(responseObject.description)
        //            self.delegate.returnObt!(responseObject, url: transac)
        //            }, failure:  { (operation: AFHTTPRequestOperation!, error: NSError!) in
        //                print(error)
        //        })
    }
    
    func performPut(url:String!, token:String!, data:NSDictionary, list:Bool, successMsg:String, failMsg:String){
        //        var operationManager = AFHTTPRequestOperationManager()
        //        // operationManager.requestSerializer  = AFJSONRequestSerializer()
        //        operationManager.responseSerializer = AFJSONResponseSerializer()
        //        operationManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        //        //[operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        //        print(URLAPI+url)
        //        operationManager.POST(URLAPI+url, parameters: nil, success:  { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
        //            print(responseObject.description)
        //            let responseDict = responseObject as! Dictionary<String , AnyObject>
        //            var token = responseDict["token"] as! String!
        //            print(token)
        //            }, failure:  { (operation: AFHTTPRequestOperation!, error: NSError!) in
        //        })
    }
}
