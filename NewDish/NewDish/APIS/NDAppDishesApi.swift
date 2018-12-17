//
//  NDAppDishesApi.swift
//  NewDish
//
//  Created by Kavya KN on 07/12/18.
//  Copyright © 2018 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire

class AppDishesModel: NSObject {
    var id : NSNumber = 0
    var name : String = ""
    var eateryDataModel : EateryDataModel = EateryDataModel()
}

class EateryDataModel: NSObject {
    var id : NSNumber = 0
    var name : String = ""
}

class NDAppDishesApi: APIBase {

    var appDishId : NSNumber = NSNumber()
    
    var appDishEateriesDataSource = AppDishesModel()
    
    override func urlForRequest() -> String {
        return self.getAppDishesUrl()
    }
    
    func getAppDishesUrl() -> String {
        return "\(APIConfig.BaseURL)app/dishes/"+"\(appDishId)"
    }
    
    // MARK: HTTP method type
    override func requestType() -> HTTPMethod {
        return .get
    }
    
    // MARK: API parameters
    override func requestParameter() -> [String : Any]? {
        return nil
    }
    
    override func customHTTPHeaders() -> Alamofire.HTTPHeaders? {
        let accessToken = UserDefaults.standard.object(forKey: kAccessTokenIdentifier)
        return ["access-token": accessToken as! String]
    }
    
    // MARK: Response parser
    override func parseAPIResponse(response: Dictionary<String, AnyObject>?) {
        print(response ?? -1)
        if response != nil {
            let responseArray = response!["Root"] as? NSArray
            for responseObject in responseArray! {
                let dictionary : NSDictionary = responseObject as! NSDictionary
                
                let appDishesModel = AppDishesModel()
                
                let id = (dictionary["id"] as! NSNumber)
                let name = (dictionary["name"] as! String)
                
                appDishesModel.id = id
                appDishesModel.name = name
                
                let eateryData = dictionary["eatery"] as! NSDictionary
                let eateryDataModel = EateryDataModel()
                eateryDataModel.id = eateryData["id"] as! NSNumber
                eateryDataModel.name = eateryData["name"] as! String
                
                appDishesModel.eateryDataModel = eateryDataModel
                
                self.appDishEateriesDataSource = appDishesModel
            }
        }
    }
    
    // MARK: Is Multipart Request
    override func isMultipartRequest() -> Bool {
        return false
    }
    
    // MARK: MultipartData
    override func multipartData(multipartData : MultipartFormData?) {
        
    }
    override func isJSONRequest() -> Bool {
        return true
    }
}
